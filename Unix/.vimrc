" Vim Plugins
call plug#begin('~/.vim/plugged')
Plug 'prabirshrestha/asyncomplete.vim'                          " Autocomplete alternative
Plug 'prabirshrestha/async.vim'                                 " Async support
Plug 'prabirshrestha/vim-lsp'                                   " LSP Support
Plug 'prabirshrestha/asyncomplete-lsp.vim'                      " LSP SUpport for asyncomplete
Plug 'thomasfaingnaert/vim-lsp-snippets'                        " Vim LSP snippets
Plug 'thomasfaingnaert/vim-lsp-ultisnips'                       " LSP Ultisnippets
Plug 'junegunn/seoul256.vim'                                    " Default color scheme
Plug '~/.fzf'                                                   " For manual installs
Plug '/usr/local/opt/fzf'                                       " For OSX based installs of FZF
Plug 'junegunn/fzf.vim'                                         " Main fzf plugin
Plug 'OmniSharp/omnisharp-vim'                                  " C# support
Plug 'SirVer/ultisnips'                                         " Allow snippets
Plug 'w0rp/ale'                                                 " Linting engine
Plug 'junegunn/goyo.vim'                                        " Pure writing
Plug 'junegunn/vim-easy-align'                                  " Vim Easy Align
Plug 'itchyny/lightline.vim'                                    " Status bar for Vim
Plug 'itchyny/vim-gitbranch'                                    " Display the current branch in vim
Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' }          " Nerdtree support
Plug 'Xuyuanp/nerdtree-git-plugin'                              " Git flags on NERDTree
Plug 'Yggdroot/indentLine'                                      " Indentation guides for Vim
Plug 'editorconfig/editorconfig-vim'                            " B/c editorconfig is important
call plug#end()

source ~/.vim/configs/async.vim
source ~/.vim/configs/editor.vim
source ~/.vim/configs/search.vim
source ~/.vim/configs/lint.vim
source ~/.vim/configs/ultisnips.vim
source ~/.vim/configs/nerdtree.vim
source ~/.vim/configs/format.vim
source ~/.vim/ftplugin/cs.vim
source ~/.vim/ftplugin/cpp.vim
