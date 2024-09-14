local mod = { }

--- The choices from the selection menu from vim.ui.select
local select_cache = { };
--- The callback applied when a choice is chosen from the selection menu
local select_callback = nil;

--- Matches for any integer in the string and casts it as an integer.
--- @param input string
local function get_index(input)
    return tonumber(string.match(input, "^(%d*)"))
end

local function code_action_sink(selected)
    vim.print(type(selected));
    local idx = get_index(selected);
    local code_action = select_cache[idx];
    if select_callback ~= nil then
        select_callback(code_action);
    else
        vim.print("No callback")
    end
end

function mod.on_select(items, _, on_choice)
    local clap_display_data = {};
    for i, item in ipairs(items) do
        clap_display_data[i] = string.format("%d: %s", i, item.action.title);
    end

    select_cache = items;
    select_callback = on_choice;
    local provider = {
        source = clap_display_data,
        sink = code_action_sink
    }
    vim.fn["clap#run"](provider);
    vim.api.nvim_input("<ESC>");
end

return mod;