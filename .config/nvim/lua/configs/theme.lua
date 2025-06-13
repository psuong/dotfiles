local theme = {};
local cast = require("helpers.cast");

vim.opt.autoread = true;    -- Automatically reload the buffer when changed outside of vim
vim.opt.hidden = true;      -- Allows you to switch the buffer without having to write/save it first
vim.opt.swapfile = false;   -- Don"t generate swap files
vim.opt.syntax = "manual";  -- Set the syntax manually for highlighting

vim.cmd("filetype plugin indent on");   -- Detect the filetypes and allow indentation based on the file types
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
vim.opt.colorcolumn = "120";
vim.opt.cursorline = true;
vim.opt.showcmd = true;
vim.opt.showmode = false;
vim.opt.laststatus = 3; -- Disable the status bar
vim.opt.completeopt = "menuone,noselect";

vim.opt.termguicolors = cast.as_bool(vim.fn.has("termguicolors"));
vim.opt.guifont = "UbuntuMono Nerd Font Propo:h12";

-- Set splitting to vertical by default
vim.opt.diffopt:append("vertical");

vim.opt.list = false;
vim.opt.backspace = { "indent", "eol", "start" };

-----------------
-- Colorscheme --
-----------------
vim.o.background = "dark";
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
});
vim.cmd("colorscheme gruvbox");

-- Define a highlight group for TODO comments
vim.cmd("highlight Todo cterm=bold gui=bold");

-- Create an autocmd to highlight TODO comments
vim.api.nvim_create_autocmd("Syntax", {
    pattern = "*",
    command = "match Todo /TODO/",
});

-- Remove undercurl
local function get_color(group, attr)
    local hl = vim.api.nvim_get_hl(0, { name = group, link = false })
    return hl and hl[attr] or "NONE";
end

local red = get_color("GruvboxRed", "fg");
local yellow = get_color("GruvboxYellow", "fg");
local gray = get_color("GruvboxGray", "fg");
local orange = get_color("GruvboxOrange", "fg");

vim.api.nvim_set_hl(0, "DiagnosticUnderlineError", { undercurl = false, underline = true, sp = red });
vim.api.nvim_set_hl(0, "DiagnosticUnderlineWarn", { undercurl = false, underline = true, sp = yellow });
vim.api.nvim_set_hl(0, "DiagnosticUnderlineHint", { undercurl = false, underline = true, sp = orange });
vim.api.nvim_set_hl(0, "DiagnosticUnderlineInfo", { undercurl = false, underline = true, sp = gray });

----------------------
-- Smooth scrolling --
----------------------
-- require("neoscroll").setup();

------------
-- Glyphs --
------------
require("nvim-web-devicons").setup();

return theme;
