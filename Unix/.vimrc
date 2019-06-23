" Vim Plugins
call plug#begin('~/.vim/plugged')
Plug 'junegunn/seoul256.vim'
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug '~/.fzf'
call plug#end()

source ~/.vim/configs/editor.vimrc
source ~/.vim/configs/search.vimrc
source ~/.vim/configs/deoplete.vimrc
