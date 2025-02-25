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
vim.o.foldlevelstart = 50;

-- Fold the function or block under the cursor
vim.api.nvim_set_keymap("n", "zz", "za", { noremap = true, silent = true });

require("nvim-treesitter.install").compilers = { "clang", "gcc" };
require("nvim-treesitter.configs").setup({
    -- A list of parser names, or "all"
    ensure_installed = {
        "c",
        "cpp",
        "c_sharp",
        "rust",
        "hlsl",
        "glsl",
        "vimdoc",
        "powershell",
        "yaml",
        "toml"
    },

    -- Install parsers synchronously (only applied to `ensure_installed`)
    sync_install = false,

    highlight = {
        -- `false` will disable the whole extension
        enable = true,
        -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
        -- Set this to `true` if you depend on "syntax" being enabled (like for indentation).
        -- Using this option may slow down your editor, and you may see some duplicate highlights.
        -- Instead of true it can also be a list of languages
        additional_vim_regex_highlighting = false,
    },
    indent = {
        enable = true
    },
});

vim.keymap.set("n", "[c", function()
    require("treesitter-context").go_to_context();
end, { silent = true });

return syntax;
