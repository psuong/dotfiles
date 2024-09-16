local mod = {}

--- The choices from the selection menu from vim.ui.select
local select_cache = {};
--- The callback applied when a choice is chosen from the selection menu
local select_callback = nil;

---@param input string
---@param pattern string
---@return number
local function get_index_with_pattern(input, pattern)
    return tonumber(string.match(input, pattern)) or 0
end

--- Matches for any integer in the string and casts it as an integer.
--- @param input string
local function default_get_index(input)
    return get_index_with_pattern(input, "%[(%d+)%]");
end

--- Launches the select_callback based on what was selected from vim-clap
--- @param selected string
local function code_action_sink(selected)
    local idx = default_get_index(selected);
    local code_action = select_cache[idx];
    if select_callback ~= nil then
       select_callback(code_action);
    else
        vim.print("No callback available")
    end
end

--- The main callback that overrides vim.ui.select's default behaviour.
---@param items table
---@param _ any
---@param on_choice function(string)
function mod.on_select(items, _, on_choice)
    local clap_display_data = {};
    for i, item in ipairs(items) do
        clap_display_data[i] = string.format("[%d]: %s", i, item.action.title);
    end

    select_cache = items;
    select_callback = on_choice;
    local provider = {
        id = "Select",
        source = clap_display_data,
        sink = code_action_sink
    }
    vim.fn["clap#run"](provider);
end

local reference_locations = {};
local current_lsp_client = {};

---@param uri string
---@return number
local function get_prefix_length(uri)
    local ordered_patterns = { "^file:///", "^file://" };

    for _, pattern in ipairs(ordered_patterns) do
        if string.find(uri, pattern) then
            return string.len(pattern);
        end
    end

    return 0;
end

---@param path string
local function get_directory_name(path)
    return path:match("([^/\\]+)$")
end

---@param path string
---@return string
local function resolve_symlink(path)
    return vim.loop.fs_realpath(path) or path
end

local function reference_sink(selected)
    if selected == nil then
        return
    end
end

function mod.clap_references_ui(client, result, ctx, config)
    reference_locations = result;
    local clap_display_data = {};
    local cwd = resolve_symlink(vim.fn.getcwd());
    for i, item in ipairs(reference_locations) do
        vim.print(item);
        local adjusted_uri = string.gsub(string.sub(item.uri, get_prefix_length(item.uri)), cwd, get_directory_name(cwd));
        clap_display_data[i] = string.format("[%d]: %s:%d", i, adjusted_uri, item.range.start.line);
    end
    local provider = {
        source = clap_display_data,
        sink = reference_sink,
        id = "References"
    };
    vim.fn["clap#run"](provider)
end

return mod;
