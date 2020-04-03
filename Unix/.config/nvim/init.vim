" Vim Plugins
call plug#begin('~/.vim/plugged')

" Icon Support
Plug 'ryanoasis/vim-devicons'                           " Add icons

" Editor View
Plug 'junegunn/seoul256.vim'                            " Default color scheme
Plug 'junegunn/goyo.vim'                                " Focused view
Plug 'junegunn/vim-easy-align'                          " Align by expressions
Plug 'preservim/nerdtree'                               " Default file tree explorer
Plug 'itchyny/lightline.vim'                            " Status bar for Vim
Plug 'itchyny/vim-gitbranch'                            " Display the current branch in vim
Plug 'editorconfig/editorconfig-vim'                    " Unified file formats
Plug 'psliwka/vim-smoothie'                             " Adds some butterly smooth scrolling

" Formats
Plug 'thaerkh/vim-indentguides'                         " Default indentation guides

" Search
Plug '~/.fzf'                                           " For manual installs
Plug 'junegunn/fzf.vim'                                 " Main fzf plugin

" Git
Plug 'junegunn/gv.vim'                                  " Git history
Plug 'tpope/vim-fugitive'                               " For gv
Plug 'APZelos/blamer.nvim'                              " Git lens like feature

" Snippets
Plug 'SirVer/ultisnips'                                 " Snippet support
Plug 'honza/vim-snippets'                               " Default snippets
Plug 'prabirshrestha/asyncomplete-ultisnips.vim'        " Ultisnips support

" Language support
Plug 'nickspoons/vim-sharpenup'                         " C# status line options
Plug 'OmniSharp/omnisharp-vim'                          " Default C# intellisense/completion
Plug 'dense-analysis/ale'                               " Linting engine
Plug 'prabirshrestha/asyncomplete.vim'                  " Autocompletion Engine
Plug 'prabirshrestha/async.vim'                         " Base autocompletion
Plug 'keremc/asyncomplete-racer.vim'

call plug#end()

source ~/.vim/configs/editor.vim
source ~/.vim/configs/lint.vim
source ~/.vim/configs/async.vim
source ~/.vim/configs/search.vim
source ~/.vim/configs/explorer.vim
source ~/.vim/configs/format.vim
source ~/.vim/ftplugin/cs.vim
source ~/.vim/ftplugin/cpp.vim
source ~/.vim/ftplugin/rust.vim
source ~/.vim/configs/statusline.vim
