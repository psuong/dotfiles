local cast = require("helpers.cast");

vim.opt.autoread = true;             -- Automatically reload the buffer when changed outside of vim
vim.opt.hidden = true;               -- Allows you to switch the buffer without having to write/save it first
vim.opt.swapfile = false;            -- Don"t generate swap files
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
vim.opt.completeopt = "menuone,noselect";

vim.opt.termguicolors = cast.as_bool(vim.fn.has("termguicolors"));

vim.cmd("set guifont=UbuntuMono\\ Nerd\\ Font\\ Propo:h12")

-- Set splitting to vertical by default
vim.opt.diffopt:append("vertical");

vim.opt.list = false;
vim.opt.backspace = { "indent", "eol", "start" }

----------------------
-- Smooth scrolling --
----------------------
require("neoscroll").setup();

------------
-- Glyphs --
------------
require("nvim-web-devicons").get_icons();

-----------
-- Theme --
-----------
vim.o.background = "dark";

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

-- -------------------
-- -- Indent guides --
-- -------------------
require("ibl").setup { indent = {
    highlight = highlight,
    char = "│"
} }

------------------------------------
-- Treesitter/Syntax Highlighting --
------------------------------------
require("nvim-treesitter.install").compilers = { "clang", "gcc" }
require("nvim-treesitter.configs").setup {
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
        enable = true,
        -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
        -- Set this to `true` if you depend on "syntax" being enabled (like for indentation).
        -- Using this option may slow down your editor, and you may see some duplicate highlights.
        -- Instead of true it can also be a list of languages
        additional_vim_regex_highlighting = false,
    },
}

------------
-- Tagbar --
------------
vim.g.tagbar_foldlevel = 3;
vim.g.tagbar_iconchars = { "▸", "▾" };
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
    private = "-"
};

-- Enable syntax for the tab bar buffer
local function enable_tagbar_syntax_coloring()
    -- Get the current buffer name
    local buffer_name = vim.api.nvim_buf_get_name(0);

    if string.find(buffer_name, "Tagbar") then
        vim.cmd("syntax enable");
    end
end

local buffer_enter_group = vim.api.nvim_create_augroup("BufferEnter", { clear = true });

vim.api.nvim_create_autocmd("BufEnter", {
    group = buffer_enter_group,
    pattern = "*",
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
vim.api.nvim_set_keymap("n", "<S-o>", ":TagbarToggle<CR>", { noremap = true, silent = true });

-- For vim doge I"m using default mappings, nothing special

-- Consider this for code formatting, hopefully it respects
-- https://github.com/lukas-reineke/lsp-format.nvim
vim.cmd([[
" NOTE: You can use other key to expand snippet.

" Expand
imap <expr> <C-j>   vsnip#expandable()  ? "<Plug>(vsnip-expand)"         : "<C-j>"
smap <expr> <C-j>   vsnip#expandable()  ? "<Plug>(vsnip-expand)"         : "<C-j>"

" Expand or jump
imap <expr> <C-k>   vsnip#available(1)  ? "<Plug>(vsnip-expand-or-jump)" : "<C-l>"
smap <expr> <C-k>   vsnip#available(1)  ? "<Plug>(vsnip-expand-or-jump)" : "<C-l>"

" Jump forward or backward
imap <expr> <C-j>   vsnip#jumpable(1)   ? "<Plug>(vsnip-jump-next)"      : "<Tab>"
smap <expr> <C-j>   vsnip#jumpable(1)   ? "<Plug>(vsnip-jump-next)"      : "<Tab>"
imap <expr> <C-k> vsnip#jumpable(-1)  ? "<Plug>(vsnip-jump-prev)"      : "<S-Tab>"
smap <expr> <C-k> vsnip#jumpable(-1)  ? "<Plug>(vsnip-jump-prev)"      : "<S-Tab>"

" Select or cut text to use as $TM_SELECTED_TEXT in the next snippet.
" See https://github.com/hrsh7th/vim-vsnip/pull/50
nmap        s   <Plug>(vsnip-select-text)
xmap        s   <Plug>(vsnip-select-text)
nmap        S   <Plug>(vsnip-cut-text)
xmap        S   <Plug>(vsnip-cut-text)
]]);

local function toggle_inlay_hint()
    vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled());
end

local local_map = function(mode, keys, func, desc)
    vim.keymap.set(mode, keys, func, { buffer = bufnr, desc = desc })
end

local function common_keybindings()
    local_map("n", "<Leader>ti", toggle_inlay_hint, "Toggle inlay hints");
    local_map("n", "<Leader>ra", vim.lsp.buf.code_action, "Run code actions");
    local_map("n", "<Leader>ga", vim.lsp.buf.declaration, "Goto declaration");
    local_map("n", "<Leader>nm", vim.lsp.buf.rename, "Rename symbol");
    local_map("n", "[[", vim.diagnostic.goto_prev, "Previous diagnostic");
    local_map("n", "]]", vim.diagnostic.goto_next, "Previous diagnostic");
    local_map("n", "<Leader>cf", vim.lsp.buf.format, "Run code formatting");
end

local capabilities = require("ddc_source_lsp").make_client_capabilities();

local path_helper = require("helpers.path_helper");
local omnisharp_bin = path_helper.expand_tilde("~/sources/language-servers/omnisharp-win-x64/OmniSharp.exe");
local pid = vim.fn.getpid();

require("lspconfig").omnisharp.setup({
    capabilities = capabilities,
    cmd = { omnisharp_bin, "--languageserver", "--hostPID", tostring(pid) },
    on_attach = function()
        common_keybindings();
        local omnisharp_extended = require("omnisharp_extended");
        local_map("n", "<Leader>gd", omnisharp_extended.lsp_definition);
        local_map("n", "<Leader>go", omnisharp_extended.lsp_type_definition);
        local_map("n", "<Leader>fu", omnisharp_extended.clap_lsp_references);
        local_map("n", "<Leader>fi", omnisharp_extended.lsp_implementation);
        local lsp_ui = require("helpers.lsp_ui");
        vim.ui.select = lsp_ui.on_select;
    end,
});

require("lspconfig").rust_analyzer.setup({
    capabilities = capabilities,
    on_attach = function()
        common_keybindings();
        local_map("n", "<Leader>gd", vim.lsp.buf.definition, "Goto definition");
        local_map("n", "<Leader>go", vim.lsp.buf.type_definition, "Goto type definition");
        local_map("n", "<Leader>gi", vim.lsp.buf.implementation, "Goto implementation");
        local_map("n", "<Leader>fu", vim.lsp.buf.references, "Find references");
    end,
});

vim.cmd([[
call ddc#custom#patch_global({
    \ 'ui': 'native',
    \ 'sources': [ 'lsp', 'vsnip' ],
    \ 'sourceOptions': {
    \   '_': {
    \       'matchers': ['matcher_fuzzy'],
    \       'sorters' : ['sorter_fuzzy'],
    \       'converters' : ['converter_fuzzy'],
    \   },
    \   'lsp': {
    \       'mark': 'LSP',
    \       'minAutoCompleteLength': 1,
    \       'forceCompletionPattern': '\.\w*|:\w*|->\w*',
    \       'maxItems': 20,
    \   },
	\   'vsnip': {
	\       'mark': 'SNIP',
    \       'maxItems': 5,
	\   },
    \ },
    \ 'sourceParams': {
    \   'lsp': {
    \       'enableResolveItem': v:true,
    \       'enableAdditionalTextEdit': v:true,
    \       'snippetEngine': denops#callback#register({
    \           body -> vsnip#anonymous(body)
    \       }),
    \   },
    \   'enableResolveItem': v:true,
    \   'enableAdditionalTextEdit': v:true,
    \ }
\ })

inoremap <expr> <TAB>
    \ pumvisible() ? '<C-n>' :
    \ (col('.') <= 1 <Bar><Bar> getline('.')[col('.') - 2] =~# '\s') ?
    \ '<TAB>' : ddc#map#manual_complete()

" <S-TAB>: completion back.
inoremap <expr><S-TAB>  pumvisible() ? '<C-p>' : '<C-h>'

" Press enter to confirm the selection
inoremap <expr> <cr>    pumvisible() ? "\<C-y>" : "\<cr>"

" Use ddc.
call ddc#enable()
" Enable pop up previews
call popup_preview#enable()
" Enable signatures for overloads with denops
call signature_help#enable()
]])
