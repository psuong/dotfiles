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

" ----------------------------------------------------------------------
" Visual Studio Like Settings
" ----------------------------------------------------------------------
set expandtab                       " Tabs are spaces
set tabstop=4                       " Number of visual spaces per tabs
set softtabstop=4                   " Number of spaces in tabs when editing
set shiftwidth=4                    " Number of spaces text is indented
set smartindent                     " Automate indenting on a new line
set signcolumn=yes                  " Always enable the sign column

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
let g:gruvbox_bold=0
colorscheme gruvbox

" ----------------------------------------------------------------------
" Font Settings
" ----------------------------------------------------------------------
if has('Unix')
    set guifont=UbuntuMono\ Nerd\ Font:h14
elseif has('Windows')
    " Disabled for now since I am sticking with nvim-qt
    " set guifont=UbuntuMono\ Nerd\ Font:h11
elseif has('macunix')
    set guifont=UbuntuMono\ Nerd\ Font:h16
endif

" ----------------------------------------------------------------------
" Cursor settings
" ----------------------------------------------------------------------
nnoremap j gj
nnoremap k gk

" ----------------------------------------------------------------------
" Terminal settings
" ----------------------------------------------------------------------
tnoremap <Esc> <C-\><C-n>
" set shell=pwsh

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
