" ----------------------------------------------------------------------
" Buffer Settings
" ----------------------------------------------------------------------
set hidden                          " Stops the buffer from closing
set noswapfile                      " Don't generate swap files
syntax off                          " Turn off syntax highlighting

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

" ----------------------------------------------------------------------
" Basic Vim Settings
" --------------------------------------------------------------------------
set nonumber                        " Hide number lines
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
set background=dark
lua <<EOF
require("gruvbox").setup({
  undercurl = true,
  underline = true,
  bold = false,
  italic = {
    strings = true,
    comments = true,
    operators = false,
    folds = true,
  },
  strikethrough = true,
  invert_selection = false,
  invert_signs = false,
  invert_tabline = false,
  invert_intend_guides = false,
  inverse = true, -- invert background for search, diffs, statuslines and errors
  contrast = "hard", -- can be "hard", "soft" or empty string
  palette_overrides = {},
  overrides = {},
  dim_inactive = false,
  transparent_mode = false,
})
vim.cmd("colorscheme gruvbox")
EOF

" ----------------------------------------------------------------------
" Font Settings
" ----------------------------------------------------------------------
if has('Unix')
    set guifont=UbuntuMono\ Nerd\ Font:h14
elseif has('Windows') && exists("g:nvy")
    " Disabled for now since I am sticking with nvim-qt
    set guifont=UbuntuMono\ Nerd\ Font:h11
elseif has('Windows') && exists('g:nvui')
    set guifont=UbuntuMono\ Nerd\ Font:h11
elseif has('macunix')
    set guifont=UbuntuMono\ Nerd\ Font:h16
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
" Vim Easy Align
" ----------------------------------------------------------------------
" Start interactive EasyAlign in visual mode (e.g. vipga)
xmap ga <Plug>(EasyAlign)

" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)

" ----------------------------------------------------------------------
" Lightline
" ----------------------------------------------------------------------
" Not really using lightline atm
set laststatus=3

" ----------------------------------------------------------------------
" Floating window
" ----------------------------------------------------------------------
let g:float_preview#docked=0

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
      ensure_installed = { "c", "c_sharp", "rust", "hlsl", "glsl" },

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
