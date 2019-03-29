" Vim Plugins
call plug#begin('~/.vim/plugged')
Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' }          " Nerdtree support
Plug 'Xuyuanp/nerdtree-git-plugin'                              " Git flags on NERDTree
Plug 'Yggdroot/indentLine'                                      " Indentation guides for Vim
Plug 'OmniSharp/omnisharp-vim'                                  " Omnisharp support
Plug 'SirVer/ultisnips'                                         " Util snippets
Plug 'w0rp/ale'                                                 " Use ALE as the engine
Plug 'itchyny/lightline.vim'                                    " Status bar for Vim
Plug 'itchyny/vim-gitbranch'                                    " Display the current branch in vim
Plug 'morhetz/gruvbox'                                          " Bad wolf fusion colourscheme
Plug 'junegunn/vim-easy-align'                                  " Vim Easy Align
Plug 'editorconfig/editorconfig-vim'                            " Allow Vim to read editorConfig files
Plug 'Valloric/YouCompleteMe'                                   " Default Completion Engine
Plug '~/.fzf'                                                   " Fuzzy finder
call plug#end()

source $HOME/.vim/configs/editor.vimrc
source $HOME/.vim/configs/nerdtree.vimrc
source $HOME/.vim/configs/format.vimrc
source $HOME/.vim/configs/syntax.vimrc
source $HOME/.vim/configs/ycm.vimrc
