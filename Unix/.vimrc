" Vim Plugins
call plug#begin('~/.vim/plugged')
Plug 'junegunn/vim-easy-align'                                  " Aligns expressions together
Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' }          " Nerdtree support
Plug 'Xuyuanp/nerdtree-git-plugin'                              " Git flags on NERDTree
Plug 'Yggdroot/indentLine'                                      " Indentation guides for Vim
Plug 'OmniSharp/omnisharp-vim'                                  " Omnisharp support
Plug 'junegunn/seoul256.vim'                                    " Colorscheme
Plug 'aradunovic/perun.vim'                                     " Dark Colourscheme
Plug 'vim-syntastic/syntastic'                                  " Syntastic
Plug 'Valloric/YouCompleteMe'                                   " YouCompleteMe
Plug 'Shougo/unite.vim'                                         " Unite Vim
Plug 'SirVer/ultisnips'                                         " Util snippets
Plug 'tpope/vim-eunuch'                                         " Make files/directories in Vim
Plug 'ctrlpvim/ctrlp.vim'                                       " CtrlP b/c I need fuzzy finders
Plug 'itchyny/calendar.vim'                                     " Trying to make Vim my personal workspace
Plug 'itchyny/lightline.vim'                                    " Status bar for Vim
Plug 'itchyny/vim-gitbranch'                                    " Display the current branch in vim
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

" Indent Guides
let g:indentLine_char = '⎸'         " Indentation line

" GUI
if has('gui_running')
    syntax enable                   " Enable syntax
    " set background=light            " Use the light background
    " colorscheme solarized           " Use the solarized colourscheme
    let g:seoul256_background = 234 " Use a slightly darker bg
    colo seoul256                   " seoul256 colorscheme (green - black)
    " colorscheme perun               " orange-black colourscheme
    " colorscheme wombat              " Wombat colourscheme
    set lines=511                   " Maximize the vertical size of the window
    set columns=1000                " Maximize the horizontal size of the window
endif

" NERDTree Settings
autocmd vimenter * NERDTree             " Autostart NERDTree
let g:NERDTreeDirArrowExpandable = '▸'  " Arrow for expanding directories
let g:NERDTreeDirArrowCollapsible = '▾' " Arrow for expanded directories
let NERDTreeShowHidden=1                " Show hidden files
map <C-n> :NERDTreeToggle<CR>           " Ctrl + N for expanding NERDTree

" Omnisharp
filetype plugin on
let g:OmniSharp_timeout = 1                                                 " Timeout in seconds to wait for a response
set noshowmatch                                                             " Speeds up performance since it searches for the first match, including ()
set completeopt=longest,menuone,preview                                     " Fetches previews
set splitbelow                                                              " Show descriptions on the bottom of vim
let g:syntastic_cs_checkers = ['syntax', 'semantic', 'issues']              " Code/syntax issues

augroup omnisharp_commands
    autocmd!
    autocmd BufEnter,TextChanged,InsertLeave *.cs SyntasticCheck            " Syntax checking
    autocmd CursorHold *.cs call OmniSharp#TypeLookupWithDocumentation()    " Show type info when cursor stops moving
    autocmd BufWritePost *.cs call OmniSharp#AddToProject()                 " Automatically add the file to the project
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

nnoremap <leader>rl :OmniSharpReloadSolution<cr>                            " Reload the solution
nnoremap <leader>cf :OmniSharpCodeFormat<cr>                                " Formats the code
nnoremap <leader>ss :OmniSharpStartServer<cr>                               " Starts omnisharp for the current sln
nnoremap <leader>sp :OmniSharpStopServer<cr>                                " Stops omnisharp for the current sln
nnoremap <leader>th :OmniSharpHighlightTypes<cr>                            " Syntax highlighting for types/interfaces
set hidden
let g:OmniSharp_want_snippet=1                                              " Snippet completion
let g:OmniSharp_selector_ui = 'unite'                                       " Use unite.vim

" Syntastic Settings
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

" Ultisnippets
let g:UltiSnipsExpandTrigger="<shift>"                          " Use shift to trigger
let g:UltiSnipsJumpForwardTrigger="<c-x>"                       " Use ctrl + x to jump forward
let g:UltiSnipsJumpBackwardTrigger="<c-z>"                      " Use ctrl + z to jump backward

" Ctrl P
let g:ctrlp_map = '<c-p>'                                       " Default mapping to Ctrl + P
let g:ctrlp_cmd = 'CtrlP'                                       " Default command is CtrlP
let g:ctrlp_working_path_mode = 'ra'                            " Let CtrlP be a working directory

" YouCompleteMe Settings
let g:ycm_global_ycm_extra_conf = '~/.vim/plugged/YouCompleteMe/.ycm_extra_conf.py'

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

" Vim Calendar
let g:calendar_google_calendar = 1
let g:calendar_google_task = 1
