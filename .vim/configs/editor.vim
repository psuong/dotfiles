" ----------------------------------------------------------------------
" Buffer Settings
" ----------------------------------------------------------------------
set hidden                          " Stops the buffer from closing
set noswapfile                      " Don't generate swap files

" ----------------------------------------------------------------------
" Plugin availability
" ----------------------------------------------------------------------
filetype plugin on                  " Enable plugins based on their extension
filetype plugin indent on           " Allow different indents per filetypes

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
set background=dark
lua <<EOF
require("gruvbox").setup({
  undercurl = true,
  underline = true,
  bold = false,
  italic = false,
  strikethrough = true,
  invert_selection = false,
  invert_signs = false,
  invert_tabline = false,
  invert_intend_guides = false,
  inverse = false, -- invert background for search, diffs, statuslines and errors
  contrast = "hard", -- can be "hard", "soft" or empty string
  overrides = {},
  dim_inactive = false,
  transparent_mode = false,
})
EOF
colorscheme gruvbox

" ----------------------------------------------------------------------
" Font Settings
" ----------------------------------------------------------------------
if has('Unix')
    set guifont=UbuntuMono\ Nerd\ Font:h14
elseif has('Windows') && exists("g:nvy")
    " Disabled for now since I am sticking with nvim-qt
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
augroup OmniSharpIntegrations
  autocmd!
  autocmd User OmniSharpProjectUpdated,OmniSharpReady call lightline#update()
augroup END

set laststatus=3

let g:sharpenup_statusline_opts = {
    \ 'TextLoading': ' O#: %s... (%p/%P) ',
    \ 'TextReady': ' O#: %s ',
    \ 'TextDead': ' O#: -- ',
    \ 'Highlight': 1,
    \ 'HiLoading': 'SharpenUpLoading',
    \ 'HiReady': 'SharpenUpReady',
    \ 'HiDead': 'SharpenUpDead'
\}

let g:lightline = {
\ 'colorscheme': 'gruvbox',
\ 'active': {
\   'right': [
\     [ 'lsp_errors', 'lsp_warnings', 'lsp_ok', 'lineinfo' ],
\     ['linter_checking', 'linter_errors', 'linter_warnings', 'linter_infos', 'linter_ok'],
\     ['lineinfo'], ['percent'],
\     ['fileformat', 'fileencoding', 'filetype', 'sharpenup']
\   ]
\ },
\ 'inactive': {
\   'right': [['lineinfo'], ['percent'], ['sharpenup']]
\ },
\ 'component': {
\   'sharpenup': sharpenup#statusline#Build()
\ },
\ 'component_expand': {
\   'linter_checking': 'lightline#ale#checking',
\   'linter_infos': 'lightline#ale#infos',
\   'linter_warnings': 'lightline#ale#warnings',
\   'linter_errors': 'lightline#ale#errors',
\   'linter_ok': 'lightline#ale#ok',
\   'lsp_warnings': 'lightline_lsp#warnings',
\   'lsp_errors':   'lightline_lsp#errors',
\   'lsp_ok':       'lightline_lsp#ok',
\  },
\ 'component_type': {
\   'linter_checking': 'right',
\   'linter_infos': 'right',
\   'linter_warnings': 'warning',
\   'linter_errors': 'error',
\   'linter_ok': 'right',
\   'lsp_warnings': 'warning',
\   'lsp_errors':   'error',
\   'lsp_ok':       'middle',
\  }
\}

" Use unicode chars for ale indicators in the statusline
let g:lightline#ale#indicator_checking = "\uf110 "
let g:lightline#ale#indicator_infos = "\uf129 "
let g:lightline#ale#indicator_warnings = "\uf071 "
let g:lightline#ale#indicator_errors = "\uf05e "
let g:lightline#ale#indicator_ok = "\uf00c "