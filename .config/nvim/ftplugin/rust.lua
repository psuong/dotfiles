local path_helper = require("helpers.path_helper");
local debug = require("configs.debug");

local function pick_files()
    path_helper.file_picker("exe", function()
        local data = {
            exe = vim.g["exe"],
        };

        path_helper.write_json_to_file(debug.json_path, data);
    end);
end

local function set_up()
    if not path_helper.file_exists(debug.json_path) then
        pick_files();
    else
        if vim.fn.confirm("Set up the debug configs again? ", "&yes \n&no", 2) == 1 then
            pick_files();
        end
    end
end

vim.keymap.set("n", "<F1>", set_up);
