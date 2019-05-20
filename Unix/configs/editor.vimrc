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
filetype plugin on                  " Enable plugins based on their extension
"filetype plugin indent on
highlight ColorColumn ctermbg=0 guibg=lightgrey

" GUI
if has('gui_running')
    syntax enable                   " Enable syntax
    set lines=999                   " Maximize the vertical size of the window
    set columns=999                 " Maximize the horizontal size of the window
    colorscheme gruvbox             " Badwolf fusion colourscheme
    set background=dark             " Use the dark background
endif

" Cursor settings
nnoremap j gj
nnoremap k gk

" Indent Guides
let g:indentLine_char_list = ['·', '|', '¦', '┆', '┊']
let g:indentLine_leadingSpaceEnabled = 1
let g:indentLine_leadingSpaceChar = '·'
let g:indentLine_color_gui = '#7C6f64'

" Airline
let g:airline_theme = 'one'

" Git Branch Status
let g:lightline = {
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'gitbranch', 'readonly', 'filename', 'modified' ] ]
      \ },
      \ 'component_function': {
      \   'gitbranch': 'gitbranch#name'
      \ },
      \ }

