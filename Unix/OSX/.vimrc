" Vim Plugins
call plug#begin('~/vimfiles/plugged')
Plug 'junegunn/vim-easy-align'                                  " Aligns expressions together
Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' }          " Nerdtree support
Plug 'Xuyuanp/nerdtree-git-plugin'                              " Git flags on NERDTree
Plug 'Yggdroot/indentLine'                                      " Indentation guides for Vim
Plug 'OmniSharp/omnisharp-vim'                                  " Omnisharp support
Plug 'Valloric/YouCompleteMe'                                   " YouCompleteMe
Plug 'SirVer/ultisnips'                                         " Util snippets
Plug 'w0rp/ale'                                                 " Use ALE as the engine
Plug 'tpope/vim-eunuch'                                         " Make files/directories in Vim
Plug 'ctrlpvim/ctrlp.vim'                                       " CtrlP b/c I need fuzzy finders
Plug 'itchyny/calendar.vim'                                     " Trying to make Vim my personal workspace
Plug 'itchyny/lightline.vim'                                    " Status bar for Vim
Plug 'itchyny/vim-gitbranch'                                    " Display the current branch in vim
Plug 'morhetz/gruvbox'                                          " Bad wolf fusion colourscheme
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
set encoding=utf-8                  " Default to UTF-8

" Indent Guides
let g:indentLine_char = '▏'         " Indentation line

" Themes
let g:airline_theme = 'one'         " Vim Airline Theme

" GUI
if has('gui_running')
    syntax enable                   " Enable syntax
    set lines=999                   " Maximize the vertical size of the window
    set columns=9999                " Maximize the horizontal size of the window
    colorscheme gruvbox             " Badwolf fusion colourscheme
    set background=dark             " Use the dark background
    " set guifont=Meslo_LG_S_DZ:h9:cANSI:qDRAFT
endif

" NERDTree Settings
autocmd vimenter * NERDTree                         " Autostart NERDTree
let g:NERDTreeDirArrowExpandable = '▸'              " Arrow to expand directories
let g:NERDTreeDirArrowCollapsible = '▾'             " Arrow for expanded directories
let NERDTreeShowHidden=1                            " Show hidden files
map <C-n> :NERDTreeToggle<CR>                       " Ctrl + N for expanding NERDTree
let NERDTreeIgnore = ['\.meta$', '\.swp$']          " Ignore meta files generated from Unity and vim swap files.

" Close NERDTree if it's the last one opened.
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

" Omnisharp
filetype plugin on
set previewheight=5                                                         " Sets the split preview height.
let g:OmniSharp_timeout=5                                                   " Timeout in seconds to wait for a response
set noshowmatch                                                             " Speeds up performance since it searches for the first match, including ()
set completeopt=longest,menuone,preview                                     " Fetches previews
set splitbelow                                                              " Show descriptions on the bottom of vim
let g:ale_linters = { 'cs': ['OmniSharp'] }                                 " Tell ALE to use Omnisharp for linting

augroup omnisharp_commands
    autocmd!

    " When Syntastic is available but not ALE, automatic syntax check on events
    " (TextChanged requires Vim 7.4)
    " autocmd BufEnter,TextChanged,InsertLeave *.cs SyntasticCheck

    " Show type information automatically when the cursor stops moving
    autocmd CursorHold *.cs call OmniSharp#TypeLookupWithoutDocumentation()

    " The following commands are contextual, based on the cursor position.
    autocmd FileType cs nnoremap <buffer> gd :OmniSharpGotoDefinition<CR>
    autocmd FileType cs nnoremap <buffer> <Leader>fi :OmniSharpFindImplementations<CR>
    autocmd FileType cs nnoremap <buffer> <Leader>fs :OmniSharpFindSymbol<CR>
    autocmd FileType cs nnoremap <buffer> <Leader>fu :OmniSharpFindUsages<CR>

    " Finds members in the current buffer
    autocmd FileType cs nnoremap <buffer> <Leader>fm :OmniSharpFindMembers<CR>

    autocmd FileType cs nnoremap <buffer> <Leader>fx :OmniSharpFixUsings<CR>
    autocmd FileType cs nnoremap <buffer> <Leader>tt :OmniSharpTypeLookup<CR>
    autocmd FileType cs nnoremap <buffer> <Leader>dc :OmniSharpDocumentation<CR>
    autocmd FileType cs nnoremap <buffer> <C-\> :OmniSharpSignatureHelp<CR>
    autocmd FileType cs inoremap <buffer> <C-\> <C-o>:OmniSharpSignatureHelp<CR>


    " Navigate up and down by method/property/field
    autocmd FileType cs nnoremap <buffer> <C-k> :OmniSharpNavigateUp<CR>
    autocmd FileType cs nnoremap <buffer> <C-j> :OmniSharpNavigateDown<CR>
augroup END

" Contextual code actions (uses fzf, CtrlP or unite.vim when available)
nnoremap <Leader><Space> :OmniSharpGetCodeActions<CR>
" Run code actions with text selected in visual mode to extract method
xnoremap <Leader><Space> :call OmniSharp#GetCodeActions('visual')<CR>

" Rename with dialog
nnoremap <Leader>nm :OmniSharpRename<CR>
nnoremap <F2> :OmniSharpRename<CR>
" Rename without dialog - with cursor on the symbol to rename: `:Rename newname`
command! -nargs=1 Rename :call OmniSharp#RenameTo("<args>")

nnoremap <Leader>cf :OmniSharpCodeFormat<CR>

" Start the omnisharp server for the current solution
nnoremap <Leader>ss :OmniSharpStartServer<CR>
nnoremap <Leader>sp :OmniSharpStopServer<CR>

" Add syntax highlighting for types and interfaces
nnoremap <Leader>th :OmniSharpHighlightTypes<CR>

set hidden
let g:OmniSharp_want_snippet=1                                              " Snippet completion
let g:OmniSharp_selector_ui = 'ctrlp'                                       " Use ctrlp for the UI instead of unite.vim

" Omnisharp Code Actions
sign define OmniSharpCodeActions text=💡
set updatetime=500

augroup OSCountCodeActions
  autocmd!
  autocmd FileType cs set signcolumn=yes
  autocmd CursorHold *.cs call OSCountCodeActions()
augroup END

function! OSCountCodeActions() abort
  if OmniSharp#CountCodeActions({-> execute('sign unplace 99')})
    let l = getpos('.')[1]
    let f = expand('%:p')
    execute ':sign place 99 line='.l.' name=OmniSharpCodeActions file='.f
  endif
endfunction

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
let g:UltiSnipsJumpBackwardTrigger="<c-c>"                      " Use ctrl + c to jump backward

" Ctrl P
let g:ctrlp_map = '<c-p>'                                       " Default mapping to Ctrl + P
let g:ctrlp_cmd = 'CtrlP'                                       " Default command is CtrlP
let g:ctrlp_working_path_mode = 'ra'                            " Let CtrlP be a working directory

" YouCompleteMe Settings
let g:ycm_global_ycm_extra_conf = '~/vimfiles/.ycm_extra_conf.py'

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
