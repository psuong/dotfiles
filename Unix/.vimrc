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
Plug '~/.fzf'                                                   " Non OSX Fuzzy finder
Plug '/usr/local/opt/fzf'                                       " OSX Fuzzy finding
Plug 'junegunn/fzf.vim'                                         " Fuzzy finding
Plug 'junegunn/seoul256.vim'                                    " Seoul colour scheme
Plug 'junegunn/goyo.vim'                                        " Pure writing
Plug 'junegunn/limelight.vim'                                   " Focused writing
call plug#end()

source $HOME/.vim/configs/editor.vimrc
source $HOME/.vim/configs/nerdtree.vimrc
source $HOME/.vim/configs/format.vimrc
source $HOME/.vim/configs/syntax.vimrc
source $HOME/.vim/configs/search.vimrc
source $HOME/.vim/configs/ycm.vimrc
