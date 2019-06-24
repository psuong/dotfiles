" Vim Plugins
call plug#begin('~/.vim/plugged')
Plug 'junegunn/seoul256.vim'
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug '~/.fzf'
Plug '/usr/local/opt/fzf'
Plug 'junegunn/fzf.vim'
call plug#end()

source ~/.vim/configs/editor.vimrc
source ~/.vim/configs/search.vimrc
source ~/.vim/configs/deoplete.vimrc
