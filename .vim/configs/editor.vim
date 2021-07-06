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

" ----------------------------------------------------------------------
" Basic Vim Settings
" --------------------------------------------------------------------------
set number                          " Show number lines
set colorcolumn=120                 " Show the max number of lines
set cursorline                      " Highlight the current line number
set showcmd                         " Show the vim commands
set wrap                            " Wrap horizontally long lines
set encoding=utf-8                  " Default to UTF-8
set noshowmode                      " Linelight shows this already
highlight ColorColumn ctermbg=0 guibg=lightgrey

" ----------------------------------------------------------------------
" Colorschemes
" ----------------------------------------------------------------------
" colo seoul256-light
" let g:seoul256_srgb = 1
colorscheme gruvbox
let g:gruvbox_bold = 0

" ----------------------------------------------------------------------
" Font Settings
" ----------------------------------------------------------------------
if has('Unix')
    set guifont=UbuntuMono\ Nerd\ Font:h14
elseif has('Windows')
    set guifont=UbuntuMono\ Nerd\ Font:h10
elseif has('macunix')
    set guifont=UbuntuMono\ Nerd\ Font:h12
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
" Ignore certain filetypes for indented lines
" ----------------------------------------------------------------------
let g:indentLine_enabled = 1
let g:indentLine_char_list = ['|', '¦']

" ----------------------------------------------------------------------
" Get a decent set up without the $ sign at eol and to allow backspace support
" ----------------------------------------------------------------------
set nolist
set backspace=indent,eol,start

if has('termguicolors')
  set termguicolors
endif
