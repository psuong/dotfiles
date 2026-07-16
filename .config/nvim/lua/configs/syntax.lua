local syntax = {};

------------------
-- Indent Lines --
------------------
local indent_scope = require("mini.indentscope");
indent_scope.setup({
    draw = {
        delay = 0,
        animation = indent_scope.gen_animation.none(),
        predicate = function() return true; end,
        priority = 2,
    },
    symbol = "│",
    filetypes = { "*" },
});

------------------------------------
-- Treesitter/Syntax Highlighting --
------------------------------------
vim.wo.foldmethod = "expr";
vim.wo.foldexpr = "v:lua.vim.treesitter.foldexpr()";
vim.opt.foldlevelstart = 99;
vim.opt.foldlevel = 99;

-- Fold the function or block under the cursor
vim.api.nvim_set_keymap("n", "zz", "za", { noremap = true, silent = true });

vim.api.nvim_create_autocmd("FileType", {
    pattern = { "*" },
    callback = function()
        local filetype = vim.bo.filetype
        if filetype and filetype ~= "" then
            local success = pcall(function()
                vim.treesitter.start()
            end)
            if not success then
                return
            end
        end
    end,
});

local treesitter = require("nvim-treesitter");
treesitter.setup({});
treesitter.install({ "rust", "c_sharp", "toml", "yaml", "powershell", "hlsl", "glsl", "slang", "markdown" });

vim.wo.foldexpr = "v:lua.vim.treesitter.foldexpr()";
vim.bo.indentexpr = "v:lua.vim.treesitter.indentexpr()";

return syntax;
