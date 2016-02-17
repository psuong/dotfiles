set nocompatible
filetype off

"Omnisharp
filetype plugin on

set tabstop=4 " number of visual spaces per tab
set softtabstop=4 " number of spaces in tab when editing
set expandtab " tabs are spaces

set number "show line numbers
set showcmd " show command in bottom bar
set cursorline " highlight current line
set cursorcolumn "vertical line

set wrap " always wrap long lines

" Pathogen
execute pathogen#infect()
syntax on
filetype plugin indent on

"Nerd Tree
map<C-n> :NERDTreeToggle<CR>

"Color Scheme
" colorscheme slate " default color scheme
colorscheme jellybeans

" Window Splitting
set splitright
set splitbelow

" Move through visual lines rather than physical
nnoremap j gj
nnoremap k gk

" CtrlP.vim
set runtimepath ^=~/.vim/bundle/ctrlp.vim
