local mod = {}

--- The choices from the selection menu from vim.ui.select
local select_cache = {};
--- The callback applied when a choice is chosen from the selection menu
local select_callback = nil;

--- Matches for any integer in the string and casts it as an integer.
--- @param input string
local function get_index(input)
    return tonumber(string.match(input, "^(%d*)"))
end

--- Launches the select_callback based on what was selected from vim-clap
--- @param selected string
local function code_action_sink(selected)
    vim.api.nvim_command("startinsert");
    local idx = get_index(selected);
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
        clap_display_data[i] = string.format("%d: %s", i, item.action.title);
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

return mod;
