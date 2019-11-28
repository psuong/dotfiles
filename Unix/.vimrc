" Vim Plugins
call plug#begin('~/.vim/plugged')
Plug 'junegunn/seoul256.vim'                           " Default color scheme
Plug 'neoclide/coc.nvim', {'branch': 'release'}        " New async complete engine to support other langs
Plug 'OmniSharp/omnisharp-vim'                         " Default C# intellisense/completion
Plug 'SirVer/ultisnips'                                " Snippet support
Plug 'honza/vim-snippets'                              " Default snippets
Plug 'thaerkh/vim-indentguides'                        " Default indentation guides
Plug '~/.fzf'                                          " For manual installs
Plug '/usr/local/opt/fzf'                              " For OSX based installs of FZF
Plug 'junegunn/fzf.vim'                                " Main fzf plugin
Plug 'dense-analysis/ale'                              " Linting engine
Plug 'junegunn/goyo.vim'                               " Pure writing
Plug 'junegunn/vim-easy-align'                         " Vim Easy Align
Plug 'itchyny/lightline.vim'                           " Status bar for Vim
Plug 'itchyny/vim-gitbranch'                           " Display the current branch in vim
Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' } " Nerdtree support
Plug 'Xuyuanp/nerdtree-git-plugin'                     " Git flags on NERDTree
Plug 'editorconfig/editorconfig-vim'                   " B/c editorconfig is important
Plug 'nickspoons/vim-sharpenup'                        " Add code actions to the status line
Plug 'junegunn/gv.vim'                                 " Git history
Plug 'tpope/vim-fugitive'                              " For gv
Plug 'psliwka/vim-smoothie'                            " Adds some butterly smooth scrolling
call plug#end()

source ~/.vim/configs/editor.vim
source ~/.vim/configs/lint.vim
source ~/.vim/configs/async.vim
source ~/.vim/configs/search.vim
source ~/.vim/configs/nerdtree.vim
source ~/.vim/ftplugin/cs.vim
source ~/.vim/ftplugin/cpp.vim
source ~/.vim/ftplugin/rust.vim
source ~/.vim/configs/statusline.vim
