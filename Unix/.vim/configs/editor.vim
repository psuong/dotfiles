" Plugin availability
filetype plugin on                  " Enable plugins based on their extension
filetype plugin indent on           " Allow different indents per filetypes

" Visual Studio Like Settings
set expandtab                       " Tabs are spaces
set tabstop=4                       " Number of visual spaces per tabs
set softtabstop=4                   " Number of spaces in tabs when editing
set shiftwidth=4                    " Number of spaces text is indented
set smartindent                     " Automate indenting on a new line

" Basic Vim Settings
set number                          " Show number lines
set colorcolumn=120                 " Show the max number of lines
set cursorline                      " Highlight the current line number
set showcmd                         " Show the vim commands
set wrap                            " Wrap horizontally long lines
set encoding=utf-8                  " Default to UTF-8
set noshowmode                      " Linelight shows this already
highlight ColorColumn ctermbg=0 guibg=lightgrey

colo seoul256-light
let g:seoul256_srgb = 1

" Cursor settings
nnoremap j gj
nnoremap k gk

" Goyo
nnoremap <Leader>go :Goyo<CR>
let g:goyo_width=120

" Set splitting to be vertical by default
set diffopt+=vertical

" Ignore certain filetypes for indented lines
let g:indentguides_ignorelist = ['text', 'md']
let g:indentguides_spacechar = '▏'