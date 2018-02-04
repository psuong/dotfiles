" Vim Plugins
call plug#begin('~/.vim/plugged')
Plug 'junegunn/vim-easy-align'                                  " Aligns expressions together
Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' }          " Nerdtree support
Plug 'Xuyuanp/nerdtree-git-plugin'                              " Git flags on NERDTree
Plug 'nathanaelkane/vim-indent-guides'                          " Indentation guides for Vim
Plug 'OmniSharp/omnisharp-vim'                                  " Omnisharp support
Plug 'junegunn/seoul256.vim'                                    " Colorscheme
Plug 'vim-syntastic/syntastic'                                  " Syntastic
call plug#end()

" Visual Studio Like Settings
set expandtab                       " Tabs are spaces
set tabstop=4                       " Number of visual spaces per tabs
set softtabstop=4                   " Number of spaces in tabs when editing
set shiftwidth=4                    " Number of spaces text is indented
set smartindent                     " Automate indenting on a new line

" Basic Vim Settings
set number                          " Show number lines
set cursorline                      " Highlight the current line number
set showcmd                         " Show the vim commands
set wrap                            " Wrap horizontally long lines
syntax enable                       " Enable the syntax

" Indent Guides
let g:indent_guides_enable_on_vim_startup = 1   " Enable on startup

" GUI
if has('gui_running')
    let g:seoul256_background = 234 " Use a slightly darker bg
    colo seoul256                   " seoul256 colorscheme
    set guifont=Menlo:h13           " Use the default font with size 14
    set lines=999                   " Maximize the vertical size of the window
    set columns=9999                " Maximize the horizontal size of the window
endif

" NERDTree Settings
autocmd vimenter * NERDTree             " Autostart NERDTree
let g:NERDTreeDirArrowExpandable = '▸'  " Arrow for expanding directories
let g:NERDTreeDirArrowCollapsible = '▾' " Arrow for expanded directories
let NERDTreeShowHidden=1                " Show hidden files
map <C-n> :NERDTreeToggle<CR>           " Ctrl + N for expanding NERDTree

" Omnisharp
filetype plugin on
let g:OmniSharp_timeout = 1                                     " Timeout in seconds to wait for a response
set noshowmatch                                                 " Speeds up performance since it searches for the first match, including ()
set completeopt=longest,menuone,preview                         " Fetches previews
set splitbelow                                                  " Show descriptions on the bottom of vim
let g:syntastic_cs_checkers = ['syntax', 'semantic', 'issues']  " Code/syntax issues

augroup omnisharp_commands
    autocmd!
    autocmd FileType cs setlocal omnifunc=OmniSharp#Complete                " Autocomplete function
    autocmd BufEnter,TextChanged,InsertLeave *.cs SyntasticCheck            " Syntax checking
    autocmd CursorHold *.cs call OmniSharp#TypeLookupWithoutDocumentation() " Show type info when cursor stops moving
    autocmd FileType cs nnoremap gd :OmniSharpGotoDefinition<cr>
    autocmd FileType cs nnoremap <leader>fi :OmniSharpFindImplementations<cr>
    autocmd FileType cs nnoremap <leader>ft :OmniSharpFindType<cr>
    autocmd FileType cs nnoremap <leader>fs :OmniSharpFindSymbol<cr>
    autocmd FileType cs nnoremap <leader>fu :OmniSharpFindUsages<cr>
    autocmd FileType cs nnoremap <leader>fm :OmniSharpFindMembers<cr>       " Finds members in the current buffer
    autocmd FileType cs nnoremap <leader>x  :OmniSharpFixIssue<cr>          " Cursor can be anywhere on the line to find an issue
    autocmd FileType cs nnoremap <leader>fx :OmniSharpFixUsings<cr>
    autocmd FileType cs nnoremap <leader>tt :OmniSharpTypeLookup<cr>
    autocmd FileType cs nnoremap <leader>dc :OmniSharpDocumentation<cr>
    autocmd FileType cs nnoremap <C-K> :OmniSharpNavigateUp<cr>             " Navigate property fields (up)
    autocmd FileType cs nnoremap <C-J> :OmniSharpNavigateDown<cr>           " Navigate property fields (down)
augroup end

nnoremap <leader>rl :OmniSharpReloadSolution<cr>                " Reload the solution
nnoremap <leader>cf :OmniSharpCodeFormat<cr>                    " Formats the code
nnoremap <leader>ss :OmniSharpStartServer<cr>                   " Starts omnisharp for the current sln
nnoremap <leader>sp :OmniSharpStopServer<cr>                    " Stops omnisharp for the current sln
nnoremap <leader>th :OmniSharpHighlightTypes<cr>                " Syntax highlighting for types/interfaces
set hidden
let g:OmniSharp_want_snippet=1                                  " Snippet completion


