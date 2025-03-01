local debug = {};

------------------------
-- Common keybindings --
------------------------

vim.keymap.set("n", "<F5>", function() require("dap").continue(); end);
vim.keymap.set("n", "<F10>", function() require("dap").step_over(); end);
vim.keymap.set("n", "<F11>", function() require("dap").step_into(); end);
vim.keymap.set("n", "<F12>", function() require("dap").step_out(); end);
vim.keymap.set("n", "<TAB>", function() require("dap").toggle_breakpoint(); end);
vim.keymap.set("n", "<S-TAB>", function() require("dap").set_breakpoint(); end);
vim.keymap.set("n", "<TAB>l",
    function() require("dap").set_breakpoint(nil, nil, vim.fn.input('Log point message: ')); end);
vim.keymap.set("n", "<Leader>dr", function() require("dap").repl.open(); end);
vim.keymap.set("n", "<Leader>dl", function() require("dap").run_last(); end);
vim.keymap.set({ 'n', 'v' }, "<Leader>dh", function() require("dap.ui.widgets").hover(); end);
vim.keymap.set({ 'n', 'v' }, "<Leader>dp", function() require("dap.ui.widgets").preview(); end);
vim.keymap.set("n", "<Leader>df",
    function()
        local widgets = require("dap.ui.widgets")
        widgets.centered_float(widgets.frames);
    end);
vim.keymap.set("n", "<Leader>ds",
    function()
        local widgets = require("dap.ui.widgets")
        widgets.centered_float(widgets.scopes);
    end);

local dap = require("dap");
----------------------------
-- Adapter Configurations --
----------------------------
dap.adapters.codelldb = {
    type = "executable",
    command = "codelldb",
    detatched = "false"
};

----------------------
-- Language Configs --
----------------------
-- dap.configurations.rust = {
--     {
--         name = "Launch",
--         type = "codelldb",
--         request = "launch",
--         program = function()
--             return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file");
--         end,
--         cwd = "${workspaceFolder}",
--         stopOnEntry = false,
--         args = {}
--     }
-- };
return debug;
