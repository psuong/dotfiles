local mod = {}

--- The choices from the selection menu from vim.ui.select
local select_cache = {};
--- The callback applied when a choice is chosen from the selection menu
local select_callback = nil;

--- The locations to cache whenever we open vim-clap references
local reference_locations = nil;
--- The current lsp client to cache
local current_lsp_client = nil;

-----------------------------------------------------------------------------------
-- Local Functions
-----------------------------------------------------------------------------------

---@param input string The string to parse and retrieve the number from
---@param pattern string The pattern to look for
---@return number n The associated number extracted via the pattern
local function get_index_with_pattern(input, pattern)
    return tonumber(string.match(input, pattern)) or 0
end

--- Matches for any integer in the string and casts it as an integer.
--- @param input string
local function default_get_index(input)
    return get_index_with_pattern(input, "%[(%d+)%]");
end

--- Replaces encoding of c%3a with C:
--- @param path string The path to a file, typically the uri
local function url_decode(path)
    return (path:gsub("%%(%x%x)", function(hex)
        return string.char(tonumber(hex, 16))
    end))
end

--- Launches the select_callback based on what was selected from vim-clap
--- @param selected string
local function code_action_sink(selected)
    local idx = default_get_index(selected);
    local code_action = select_cache[idx];
    if select_callback ~= nil then
        select_callback(code_action);
    else
        vim.notify("No callback available", vim.log.levels.WARN);
    end
end

--- Matches the prefix length of the uri from the lsp
---@param uri string The path to a file from an LSP
---@return number n The total # of chars in the string
local function get_prefix_length(uri)
    local ordered_patterns = { "^file:///", "^file://" };

    for _, pattern in ipairs(ordered_patterns) do
        if string.find(uri, pattern) then
            return string.len(pattern);
        end
    end

    return 0;
end

--- Gets the last directory in the breadcrumb
---@param path string The absolute path
local function get_directory_name(path)
    return path:match("([^/\\]+)$");
end

--- Checks if the path is a real path or a symlink
---@param path string The path to a directory or a file
---@return string p The real path if it is a symbolic link, otherwise the path itself
local function resolve_symlink(path)
    return vim.loop.fs_realpath(path) or path;
end

--- Callback for when we select an option in vim clap's menu navigation
---@param selected string The current line's display info
local function reference_sink(selected)
    if selected == nil then
        return;
    end

    -- Parse out the relevant info
    local idx = default_get_index(selected);
    if reference_locations == nil then
        vim.notify("Code locations were not stored!", vim.log.levels.ERROR);
        return;
    end

    local location = reference_locations[idx];

    if current_lsp_client ~= nil then
        vim.lsp.util.jump_to_location(location, "utf-8", true);
    else
        -- TODO: Jump to the location by calling vim's raw apis
    end
end

--- Checks whether the supplied path is valid
---@param path string The path to check
---@return boolean b True, if the path is valid, otherwise false
local function is_path_valid(path)
    local stat = vim.loop.fs_stat(path);
    return stat ~= nil;
end

--- Shows the file preview for vim-clap based on the current line's diagnostics in the nav menu.
--- TODO: Override this per lsp?
local function on_move()
    local cwd = resolve_symlink(vim.fn.getcwd());
    local dir_name = get_directory_name(cwd);
    local current_line = vim.api.nvim_call_dict_function("g:clap.display", "getcurline", {});
    local result = string.gsub(string.match(current_line, "%[.-%]:(.-):%d+"), " ", "");
    local line = tonumber(string.match(current_line, "%d+$")) + 1;

    local preview_at = vim.fn["clap#preview#file_at"];

    if is_path_valid(result) then
        preview_at(result, line);
    else
        -- TODO: Add a callback to call preview_at
        local path = string.format("%s%s", string.gsub(cwd, dir_name, ""), result);
        preview_at(path, line);
    end
end

-----------------------------------------------------------------------------------
-- Public Functions
-----------------------------------------------------------------------------------
local default_select = vim.ui.select;

--- The main callback that overrides vim.ui.select's default behaviour.
---@param items table
---@param opts any
---@param on_choice function(string)
function mod.on_select(items, opts, on_choice)
    if opts.kind == "codeaction" then
        local clap_display_data = {};
        for i, item in ipairs(items) do
            if item.action ~= nil then
                clap_display_data[i] = string.format("[%d]: %s", i, item.action.title);
            end
        end

        select_cache = items;
        select_callback = on_choice;
        local provider = {
            id = "Select",
            source = clap_display_data,
            sink = code_action_sink
        }
        vim.fn["clap#run"](provider);
    else
        default_select(items, opts, on_choice);
    end
end

function mod.clap_references_ui(err, result, ctx, _)
    if err then
        vim.notify("Errored out when gathering references", vim.log.levels.ERROR);
        return;
    end

    reference_locations = result;
    current_lsp_client = vim.lsp.get_client_by_id(ctx.client_id);

    local clap_display_data = {};
    local cwd = resolve_symlink(vim.fn.getcwd());
    for i, item in ipairs(reference_locations) do
        local uri = url_decode(item.uri);
        local adjusted_uri = string.gsub(
            string.sub(uri, get_prefix_length(uri)),
            cwd,
            get_directory_name(cwd));

        clap_display_data[i] = string.format("[%d]: %s:%d", i, adjusted_uri, item.range.start.line);
    end
    local provider = {
        source = clap_display_data,
        sink = reference_sink,
        on_move = on_move,
        id = "References"
    };
    vim.fn["clap#run"](provider);
end

return mod;
