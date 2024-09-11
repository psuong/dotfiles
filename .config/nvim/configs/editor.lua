local cast = require("helpers.cast");

vim.opt.autoread = true;             -- Automatically reload the buffer when changed outside of vim
vim.opt.hidden = true;               -- Allows you to switch the buffer without having to write/save it first
vim.opt.swapfile = false;            -- Don't generate swap files
vim.cmd("syntax manual");            -- Set the syntax manually for highlighting

vim.cmd("filetype plugin indent on") -- Detect the filetypes and allow indentation based on the file types
-- Font Encoding
vim.opt.encoding = "UTF-8";

-- Visual Studio Like Settings
vim.opt.expandtab = true; -- Tabs are spaces
vim.opt.tabstop = 4;      -- # of spaces per tab
vim.opt.shiftwidth = 4;   -- Make it consistent with tab stop
vim.opt.smartindent = true;
vim.opt.signcolumn = "yes";
vim.opt.title = true;
vim.opt.linespace = 1;

vim.opt.number = true;
vim.opt.colorcolumn = "100";
vim.opt.cursorline = true;
vim.opt.showcmd = true;
vim.opt.showmode = false;
vim.opt.laststatus = 3; -- Disable the status bar

vim.opt.termguicolors = cast.as_bool(vim.fn.has('termguicolors'));

vim.cmd("set guifont=UbuntuMono\\ Nerd\\ Font\\ Propo:h12")

-- Set splitting to vertical by default
vim.opt.diffopt:append("vertical");

vim.opt.list = false;
vim.opt.backspace = { "indent", "eol", "start" }

----------------------
-- Smooth scrolling --
----------------------
require('neoscroll').setup()

------------
-- Glyphs --
------------
require 'nvim-web-devicons'.get_icons()

-----------
-- Theme --
-----------
vim.o.background = 'dark'
vim.cmd([[colorscheme gruvbox]])

-- Default options:
require("gruvbox").setup({
    terminal_colors = true, -- add neovim terminal colors
    undercurl = true,
    underline = true,
    bold = false,
    italic = {
        strings = false,
        emphasis = true,
        comments = false,
        operators = false,
        folds = true,
    },
    strikethrough = true,
    invert_selection = false,
    invert_signs = false,
    invert_tabline = false,
    invert_intend_guides = false,
    inverse = true, -- invert background for search, diffs, statuslines and errors
    contrast = "",  -- can be "hard", "soft" or empty string
    palette_overrides = {},
    overrides = {},
    dim_inactive = false,
    transparent_mode = false,
})
vim.cmd("colorscheme gruvbox")

local highlight = {
    "RainbowRed",
    "RainbowYellow",
    "RainbowBlue",
    "RainbowOrange",
    "RainbowGreen",
    "RainbowViolet",
    "RainbowCyan",
}

local hooks = require("ibl.hooks")
-- create the highlight groups in the highlight setup hook, so they are reset
-- every time the colorscheme changes
hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
    vim.api.nvim_set_hl(0, "RainbowRed", { fg = "#E06C75" })
    vim.api.nvim_set_hl(0, "RainbowYellow", { fg = "#E5C07B" })
    vim.api.nvim_set_hl(0, "RainbowBlue", { fg = "#61AFEF" })
    vim.api.nvim_set_hl(0, "RainbowOrange", { fg = "#D19A66" })
    vim.api.nvim_set_hl(0, "RainbowGreen", { fg = "#98C379" })
    vim.api.nvim_set_hl(0, "RainbowViolet", { fg = "#C678DD" })
    vim.api.nvim_set_hl(0, "RainbowCyan", { fg = "#56B6C2" })
end)

-------------------
-- Indent guides --
-------------------
require("ibl").setup { indent = {
    highlight = highlight,
    char = "│"
} }

------------------------------------
-- Treesitter/Syntax Highlighting --
------------------------------------
require('nvim-treesitter.install').compilers = { "clang", "gcc" }
require('nvim-treesitter.configs').setup {
    -- A list of parser names, or "all"
    ensure_installed = {
        "c",
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
        enable = false,
        -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
        -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
        -- Using this option may slow down your editor, and you may see some duplicate highlights.
        -- Instead of true it can also be a list of languages
        additional_vim_regex_highlighting = false,
    },
}

------------
-- Tagbar --
------------
vim.g.tagbar_foldlevel = 3;
vim.g.tagbar_iconchars = { '▸', '▾' };
vim.g.tagbar_show_tag_linenumbers = 1;
vim.g.tagbar_scopestrs = {
    ["class"] = "\u{f0e8}",
    ["const"] = "\u{f8ff}",
    ["constant"] = "\u{f8ff}",
    ["enum"] = "\u{f702}",
    ["field"] = "\u{f30b}",
    ["func"] = "\u{1d453}",
    ["method"] = "\u{1d453}",
    ["function"] = "\u{1d453}",
    ["getter"] = "-->",
    ["implementation"] = "\u{f776}",
    ["interface"] = "\u{f7fe}",
    ["map"] = "\u{fb44}",
    ["member"] = "\u{f02b}",
    ["setter"] = "<--",
    ["variable"] = "\u{f71b}",
    ["namespace"] = "\u{2026}",
    ["struct"] = "\u{03C8}"
};

vim.g.tagbar_visbility_symbols = {
    public = "+",
    protected = "*",
    private = '-'
};

-- Enable syntax for the tab bar buffer
local function enable_tagbar_syntax_coloring()
    -- Get the current buffer name
    local buffer_name = vim.api.nvim_buf_get_name(0);

    if string.find(buffer_name, 'Tagbar') then
        vim.cmd("syntax enable");
    end
end

local buffer_enter_group = vim.api.nvim_create_augroup('BufferEnter', { clear = true });

vim.api.nvim_create_autocmd('BufEnter', {
    group = buffer_enter_group,
    pattern = '*',
    callback = enable_tagbar_syntax_coloring,
});

-----------------
-- Keybindings --
-----------------
vim.keymap.set("n", "j", "gj");
vim.keymap.set("n", "k", "gk");
vim.g.mapleader = ",";

vim.keymap.set("n", "[c", function()
    require("treesitter-context").go_to_context();
end, { silent = true });

-- Tagbar
vim.api.nvim_set_keymap('n', '<S-o>', ':TagbarToggle<CR>', { noremap = true, silent = true });

-- For vim doge I'm using default mappings, nothing special