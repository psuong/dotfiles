" ----------------------------------------------------------------------
" Buffer Settings
" ----------------------------------------------------------------------
set hidden                          " Stops the buffer from closing
set noswapfile                      " Don't generate swap files
syntax manual                       " Make syntax highlighting manual

" ----------------------------------------------------------------------
" Plugin availability
" ----------------------------------------------------------------------
filetype plugin indent on

" ----------------------------------------------------------------------
" Font Encoding
" ----------------------------------------------------------------------
set encoding=UTF-8
scriptencoding utf-8

" ----------------------------------------------------------------------
" Visual Studio Like Settings
" ----------------------------------------------------------------------
set expandtab                       " Tabs are spaces
set tabstop=4                       " Number of visual spaces per tabs
set softtabstop=4                   " Number of spaces in tabs when editing
set shiftwidth=4                    " Number of spaces text is indented
set smartindent                     " Automate indenting on a new line
set signcolumn=yes                  " Always enable the sign column
set title
set linespace=1

" ----------------------------------------------------------------------
" Basic Vim Settings
" --------------------------------------------------------------------------
set number                          " Show number lines
set colorcolumn=100                 " Show the max number of lines
set cursorline                      " Highlight the current line number
set showcmd                         " Show the vim commands
set wrap                            " Wrap horizontally long lines
set encoding=utf-8                  " Default to UTF-8
set noshowmode                      " Linelight shows this already
highlight ColorColumn ctermbg=0 guibg=lightgrey

" ----------------------------------------------------------------------
" Colorschemes
" ----------------------------------------------------------------------
" ----------------------------------------------------------------------
" ALE implementation for OmniSharp
" ----------------------------------------------------------------------
augroup ColorschemePreferences
  autocmd!
  " These preferences clear some gruvbox background colours, allowing transparency
  " autocmd ColorScheme * highlight Normal     ctermbg=NONE guibg=NONE
  " autocmd ColorScheme * highlight SignColumn ctermbg=NONE guibg=NONE
  " autocmd ColorScheme * highlight Todo       ctermbg=NONE guibg=NONE
  " Link ALE sign highlights to similar equivalents without background colours
  autocmd ColorScheme * highlight link ALEErrorSign   WarningMsg
  autocmd ColorScheme * highlight link ALEWarningSign ModeMsg
  autocmd ColorScheme * highlight link ALEInfoSign    Identifier
augroup END

" Use truecolor in the terminal, when it is supported
if has('termguicolors')
  set termguicolors
endif

" ----------------------------------------------------------------------
" ColorScheme + IndentLine
" ----------------------------------------------------------------------
lua <<EOF
require'nvim-web-devicons'.get_icons()

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
  contrast = "", -- can be "hard", "soft" or empty string
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

local hooks = require "ibl.hooks"
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

require("ibl").setup { indent = { 
    highlight = highlight,
    char = "│"
} }
EOF

" --------------------------------------------------------
" Add Tab Bars
" --------------------------------------------------------
" Move to previous/next
nnoremap <silent>    <A-,> <Cmd>BufferPrevious<CR>
nnoremap <silent>    <A-.> <Cmd>BufferNext<CR>

" Re-order to previous/next
nnoremap <silent>    <A-<> <Cmd>BufferMovePrevious<CR>
nnoremap <silent>    <A->> <Cmd>BufferMoveNext<CR>

" Goto buffer in position...
nnoremap <silent>    <A-1> <Cmd>BufferGoto 1<CR>
nnoremap <silent>    <A-2> <Cmd>BufferGoto 2<CR>
nnoremap <silent>    <A-3> <Cmd>BufferGoto 3<CR>
nnoremap <silent>    <A-4> <Cmd>BufferGoto 4<CR>
nnoremap <silent>    <A-5> <Cmd>BufferGoto 5<CR>
nnoremap <silent>    <A-6> <Cmd>BufferGoto 6<CR>
nnoremap <silent>    <A-7> <Cmd>BufferGoto 7<CR>
nnoremap <silent>    <A-8> <Cmd>BufferGoto 8<CR>
nnoremap <silent>    <A-9> <Cmd>BufferGoto 9<CR>
nnoremap <silent>    <A-0> <Cmd>BufferLast<CR>

" Pin/unpin buffer
nnoremap <silent>    <A-p> <Cmd>BufferPin<CR>

" Close buffer
nnoremap <silent>    <A-c> <Cmd>BufferClose<CR>
" Restore buffer
nnoremap <silent>    <A-s-c> <Cmd>BufferRestore<CR>

" Wipeout buffer
"                          :BufferWipeout
" Close commands
"                          :BufferCloseAllButCurrent
"                          :BufferCloseAllButVisible
"                          :BufferCloseAllButPinned
"                          :BufferCloseAllButCurrentOrPinned
"                          :BufferCloseBuffersLeft
"                          :BufferCloseBuffersRight

" Magic buffer-picking mode
nnoremap <silent> <C-p>    <Cmd>BufferPick<CR>
nnoremap <silent> <C-p>    <Cmd>BufferPickDelete<CR>

" Sort automatically by...
nnoremap <silent> <Space>bb <Cmd>BufferOrderByBufferNumber<CR>
nnoremap <silent> <Space>bd <Cmd>BufferOrderByDirectory<CR>
nnoremap <silent> <Space>bl <Cmd>BufferOrderByLanguage<CR>
nnoremap <silent> <Space>bw <Cmd>BufferOrderByWindowNumber<CR>

" Other:
" :BarbarEnable - enables barbar (enabled by default)

" ----------------------------------------------------------------------
" Font Settings
" ----------------------------------------------------------------------
set guifont=UbuntuMono\ Nerd\ Font\ Propo:h12

if exists('g:neovide')
    let g:neovide_cursor_animation_length = 0
    let g:neovide_cursor_vfx_mode = ""
    let g:neovide_floating_shadow = v:false
    let g:neovide_scroll_animation_length = 0
endif

" ----------------------------------------------------------------------
" Cursor settings
" ----------------------------------------------------------------------
nnoremap j gj
nnoremap k gk

" ----------------------------------------------------------------------
" Remap the leader key
" ----------------------------------------------------------------------
let mapleader = ","

" ----------------------------------------------------------------------
" Set splitting to be vertical by default
" ----------------------------------------------------------------------
set diffopt+=vertical

" ----------------------------------------------------------------------
" Indent Guides
" ----------------------------------------------------------------------
let g:indent_blankline_filetype_exclude = ['fern']

" ----------------------------------------------------------------------
" Get a decent set up without the $ sign at eol and to allow backspace support
" ----------------------------------------------------------------------
set nolist
set backspace=indent,eol,start

if has('termguicolors')
  set termguicolors
endif

" ----------------------------------------------------------------------
" Lightline
" ----------------------------------------------------------------------
set laststatus=3
let g:sharpenup_statusline_opts = {
\   'TextLoading': ' O#: %s ... (%p / %P) ',
\   'TextReady': ' O#: %s ✓ ',
\   'TextDead': ' O#: ✖ ',
\   'Highlight': 1,
\   'HiLoading': 'SharpenUpLoading',
\   'HiReady': 'SharpenUpReady',
\   'HiDead': 'SharpenUpDead'
\}

let g:lightline_lsp_signs_ok = '✓'

let g:lightline = {
\   'active': {
\       'right': [['filetype'], ['sharpenup']],
\       'left': [['mode'], ['linter_checking', 'linter_errors', 'linter_warnings', 'linter_infos', 'linter_ok']]
\   },
\   'inactive': {
\       'right': [['sharpenup']]
\   },
\   'component': {
\       'sharpenup': sharpenup#statusline#Build()
\   },
\   'component_expand': {
\       'linter_checking': 'lightline#ale#checking',
\       'linter_infos': 'lightline#ale#infos',
\       'linter_warnings': 'lightline#ale#warnings',
\       'linter_errors': 'lightline#ale#errors',
\       'linter_ok': 'lightline#ale#ok',
\   },
\   'component_type':  {
\       'linter_checking': 'right',
\       'linter_infos': 'right',
\       'linter_warnings': 'warning',
\       'linter_errors': 'error',
\       'linter_ok': 'right',
\   }
\}

augroup lightline_integration
  autocmd!
  autocmd User OmniSharpStarted,OmniSharpReady,OmniSharpStopped call lightline#update()
augroup END

" ----------------------------------------------------------------------
" Smoothscrolling
" ----------------------------------------------------------------------
lua <<EOF
  require('neoscroll').setup()
EOF

" ----------------------------------------------------------------------
" Treesitter
" ----------------------------------------------------------------------
lua <<EOF
    require('nvim-treesitter.install').compilers = { "clang", "gcc" }
    require('nvim-treesitter.configs').setup {
      -- A list of parser names, or "all"
      ensure_installed = { "c", "c_sharp", "rust", "hlsl", "glsl", "vimdoc" },

      -- Install parsers synchronously (only applied to `ensure_installed`)
      sync_install = false,

      highlight = {
        -- `false` will disable the whole extension
        enable = true,
        -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
        -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
        -- Using this option may slow down your editor, and you may see some duplicate highlights.
        -- Instead of true it can also be a list of languages
        additional_vim_regex_highlighting = false,
      },
    }
    vim.keymap.set("n", "[c", function()
        require("treesitter-context").go_to_context()
    end, { silent = true })
EOF

let g:lsp_log_verbose = 1
let g:lsp_log_file = expand('~/vim-lsp.log')
