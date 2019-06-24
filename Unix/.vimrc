" Vim Plugins
call plug#begin('~/.vim/plugged')
" Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }  " Deoplete new async engine (have to figure out)
" Plug 'Shougo/deoplete-clangx'                                  " Deoplete C++ support
Plug 'junegunn/seoul256.vim'                                    " Default color scheme
Plug '~/.fzf'                                                   " For manual installs
Plug '/usr/local/opt/fzf'                                       " For OSX based installs of FZF
Plug 'junegunn/fzf.vim'                                         " Main fzf plugin
Plug 'OmniSharp/omnisharp-vim'                                  " C# support
" Plug 'nickspoons/vim-sharpenup'                                 " C# extra actions
Plug 'SirVer/ultisnips'                                         " Allow snippets
Plug 'w0rp/ale'                                                 " Linting engine
Plug 'junegunn/goyo.vim'                                        " Pure writing
Plug 'junegunn/limelight.vim'                                   " Focused writing
Plug 'Valloric/YouCompleteMe'                                   " C++ / Async engine
Plug 'junegunn/vim-easy-align'                                  " Vim Easy Align
Plug 'itchyny/lightline.vim'                                    " Status bar for Vim
Plug 'itchyny/vim-gitbranch'                                    " Display the current branch in vim
Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' }          " Nerdtree support
Plug 'Xuyuanp/nerdtree-git-plugin'                              " Git flags on NERDTree
Plug 'Yggdroot/indentLine'                                      " Indentation guides for Vim
call plug#end()

" source ~/.vim/configs/deoplete.vim                            " New deoplete stuff (have to figure out)
source ~/.vim/configs/editor.vim
source ~/.vim/configs/search.vim
source ~/.vim/configs/lint.vim
source ~/.vim/configs/ultisnips.vim
source ~/.vim/configs/nerdtree.vim
source ~/.vim/configs/format.vim
source ~/.vim/ftplugin/cs.vim
