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

-- require("nvim-treesitter.install").compilers = { "clang", "gcc" };
-- require("nvim-treesitter.configs").setup({
--     -- A list of parser names, or "all"
--     ensure_installed = {
--         "c",
--         "cpp",
--         "c_sharp",
--         "rust",
--         "hlsl",
--         "glsl",
--         "vimdoc",
--         "powershell",
--         "yaml",
--         "toml",
--         "json",
--         "cmake",
--         "slang"
--     },
-- 
--     -- Install parsers synchronously (only applied to `ensure_installed`)
--     sync_install = false,
-- 
--     highlight = {
--         -- `false` will disable the whole extension
--         enable = true,
--         -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
--         -- Set this to `true` if you depend on "syntax" being enabled (like for indentation).
--         -- Using this option may slow down your editor, and you may see some duplicate highlights.
--         -- Instead of true it can also be a list of languages
--         additional_vim_regex_highlighting = false,
--     },
--     indent = {
--         enable = true
--     },
-- });

local treesitter = require("nvim-treesitter");
treesitter.setup({
    -- install_dir = vim.fn.stdpath("data") .. "/site"
});
treesitter.install({ "rust", "c_sharp", "c", "cpp", "hlsl", "slang", "glsl", "powershell", "yaml", "toml" });

require("nvim-treesitter-textobjects").setup({
    select = {
        enable = true,
        lookahead = true,
        selection_modes = {
            ["@parameter.outer"] = "v", -- charwise
            ["@function.outer"] = "V", -- linewise
            ["@class.outer"] = "<c-v>", -- blockwise
        },
        include_surrounding_whitespace = false,
    },
    move = {
        enable = true,
        set_jumps = true,
    },
});

-- SELECT keymaps
local sel = require("nvim-treesitter-textobjects.select")
for _, map in ipairs({
    { { "x", "o" }, "af", "@function.outer" },
    { { "x", "o" }, "if", "@function.inner" },
    { { "x", "o" }, "ac", "@class.outer" },
    { { "x", "o" }, "ic", "@class.inner" },
    { { "x", "o" }, "aa", "@parameter.outer" },
    { { "x", "o" }, "ia", "@parameter.inner" },
    { { "x", "o" }, "ad", "@comment.outer" },
    { { "x", "o" }, "as", "@statement.outer" },
}) do
    vim.keymap.set(map[1], map[2], function()
        sel.select_textobject(map[3], "textobjects");
    end, { desc = "Select " .. map[3] });
end

-- MOVE keymaps
local mv = require("nvim-treesitter-textobjects.move")
for _, map in ipairs({
    { { "n", "x", "o" }, "]m", mv.goto_next_start, "@function.outer" },
    { { "n", "x", "o" }, "[m", mv.goto_previous_start, "@function.outer" },
    { { "n", "x", "o" }, "]]", mv.goto_next_start, "@class.outer" },
    { { "n", "x", "o" }, "[[", mv.goto_previous_start, "@class.outer" },
    { { "n", "x", "o" }, "]M", mv.goto_next_end, "@function.outer" },
    { { "n", "x", "o" }, "[M", mv.goto_previous_end, "@function.outer" },
    { { "n", "x", "o" }, "]o", mv.goto_next_start, { "@loop.inner", "@loop.outer" } },
    { { "n", "x", "o" }, "[o", mv.goto_previous_start, { "@loop.inner", "@loop.outer" } },
}) do
    local modes, lhs, fn, query = map[1], map[2], map[3], map[4]
    -- build a human-readable desc
    local qstr = (type(query) == "table") and table.concat(query, ",") or query
    vim.keymap.set(modes, lhs, function()
        fn(query, "textobjects")
    end, { desc = "Move to " .. qstr })
end

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

vim.wo.foldexpr = "v:lua.vim.treesitter.foldexpr()";
vim.bo.indentexpr = "v:lua.vim.treesitter.indentexpr()";

return syntax;
