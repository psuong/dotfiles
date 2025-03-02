local debug = {};
local dap = require("dap");
local widgets = require("dap.ui.widgets");
local path_helper = require("helpers.path_helper");

debug.json_path = string.format("%s\\.debug\\config.json", vim.fn.getcwd());

------------------------
-- Common keybindings --
------------------------
vim.keymap.set("n", "<S-TAB>", function() dap.set_breakpoint(); end);
vim.keymap.set("n", "<TAB>l",
    function() require("dap").set_breakpoint(nil, nil, vim.fn.input("Log point message: ")); end);
vim.keymap.set("n", "<Leader>dr", function() dap.repl.open(); end);
vim.keymap.set("n", "<Leader>dl", function() dap.run_last(); end);
vim.keymap.set({ "n", "v" }, "<Leader>dh", function() widgets.hover(); end);
vim.keymap.set({ "n", "v" }, "<Leader>dp", function() widgets.preview(); end);
vim.keymap.set("n", "<Leader>df",
    function()
        widgets.centered_float(widgets.frames);
    end);
vim.keymap.set("n", "<Leader>ds",
    function()
        widgets.centered_float(widgets.scopes);
    end);

vim.keymap.set("n", "<F4>", ":DapDisconnect<CR>");
vim.keymap.set("n", "<S-F4>", ":DapTerminate<CR>");
vim.keymap.set("n", "<F3>", ":DapNew<CR>");
vim.keymap.set("n", "<F5>", function() dap.continue(); end);

-- Idk what eval does, from the docs:
-- >vim
-- au FileType dap-repl lua require('dap.ext.autocompl').attach()
vim.keymap.set("n", "<F6>", ":DapEval<CR>");
vim.keymap.set("n", "<F7>", ":DapToggleRepl<CR>");
vim.keymap.set("n", "<C-0>", ":DapClearBreakpoints<CR>");
vim.keymap.set("n", "<F10>", function() dap.step_over(); end);
vim.keymap.set("n", "<F11>", function() dap.step_into(); end);
vim.keymap.set("n", "<F12>", function() dap.step_out(); end);
vim.keymap.set("n", "<TAB>", function() dap.toggle_breakpoint(); end);

----------------------------
-- Adapter Configurations --
----------------------------
dap.adapters.codelldb = {
    type = "executable",
    command = "codelldb",
    detatched = "false"
};

dap.adapters.coreclr = {
    type = "executable",
    command = "netcoredbg",
    args = { "--interpreter=vscode" }
};

----------------------
-- Language Configs --
----------------------
--- Rust
dap.configurations.rust = {
    {
        type = "codelldb",
        name = "launch - codelldb",
        request = "launch",
        program = function()
            return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file");
        end,
        cwd = "${workspaceFolder}",
        stopOnEntry = false,
        args = {}
    }
};

-- CSharp/Dotnet
local function dotnet_build_project(csproj)
    local cmd = string.format("dotnet build -c Debug %s", csproj);
    local f = os.execute(cmd);
    if f == 0 then
        vim.print("\nBuild succeeded!");
    else
        vim.print("\nBuild failed: (code: " .. f .. ")");
    end
end

local config = {
    {
        type = "coreclr",
        name = "launch - netcoredbg",
        request = "launch",
        program = function()
            if not path_helper.file_exists(debug.json_path) then
                vim.print("Error: Press <F1> to setup your debug configs.");
                return "";
            else
                local data = path_helper.read_json_file(debug.json_path);
                if data ~= nil then
                    if vim.fn.confirm("Should I recompile first?", "&yes\n&no", 2) == 1 then
                        dotnet_build_project(data.csproj);
                    end
                    return data.dll;
                end
                return "";
            end
        end,
    },
};

dap.configurations.cs = config;

-- TODO: Add a key to hide the terminal without closing it
-- https://github.com/mfussenegger/nvim-dap/issues/243
debug.terminal = require("dap.ui").new_view(
    function()
        return vim.api.nvim_create_buf(false, true);
    end,
    function(buf)
        vim.cmd("split");
        local win = vim.api.nvim_get_current_win();
        vim.api.nvim_win_set_buf(win, buf);
        return win;
    end
);
dap.defaults.fallback.terminal_win_cmd = ":lua require(\"configs.debug\").terminal.open()";
vim.api.nvim_set_keymap("n", "<C-t>", ":lua require(\"configs.debug\").terminal.toggle()<CR>",
    { noremap = true, silent = true });

require("nvim-dap-virtual-text").setup();

return debug;
