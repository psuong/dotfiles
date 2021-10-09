"------------------------------------------------------------------------------------------------
" Vim Plugins
"------------------------------------------------------------------------------------------------
call plug#begin('~/.vim/plugged')

"------------------------------------------------------------------------------------------------
" Editor View
"------------------------------------------------------------------------------------------------
Plug 'junegunn/seoul256.vim'                            " Default color scheme
Plug 'gruvbox-community/gruvbox'                        " Gruvbox retro theme
Plug 'junegunn/vim-easy-align'                          " Align by expressions
Plug 'itchyny/lightline.vim'                            " Status bar for Vim
Plug 'itchyny/vim-gitbranch'                            " Display the current branch in vim
Plug 'editorconfig/editorconfig-vim'                    " Unified file formats
Plug 'psliwka/vim-smoothie'                             " Adds some butterly smooth scrolling
Plug 'lambdalisue/fern.vim'                             " Default file explorer

"------------------------------------------------------------------------------------------------
" Formats
"------------------------------------------------------------------------------------------------
Plug 'Yggdroot/indentLine'                              " Default indentation guides

"------------------------------------------------------------------------------------------------
" Search
"------------------------------------------------------------------------------------------------
Plug '~/.fzf'                                           " For manual installs
Plug 'junegunn/fzf.vim'                                 " Main fzf plugin

"------------------------------------------------------------------------------------------------
" Git
"------------------------------------------------------------------------------------------------
Plug 'rhysd/git-messenger.vim'                          " Git lens but with pop ups instead
Plug 'lambdalisue/gina.vim'                             " Git integration

"------------------------------------------------------------------------------------------------
" Autocompletion
"------------------------------------------------------------------------------------------------
Plug 'prabirshrestha/async.vim'                         " Base autocompletion
Plug 'prabirshrestha/asyncomplete.vim'                  " Autocompletion Engine
Plug 'prabirshrestha/asyncomplete-file.vim'             " File completion
Plug 'prabirshrestha/asyncomplete-lsp.vim'              " Asyncomplete LSP

"------------------------------------------------------------------------------------------------
" Snippets
"------------------------------------------------------------------------------------------------
Plug 'prabirshrestha/asyncomplete-ultisnips.vim'        " Ultisnips support
Plug 'SirVer/ultisnips'                                 " Snippet support
Plug 'honza/vim-snippets'                               " Common snippets
Plug 'hrsh7th/vim-vsnip'                                " Snippet support for LSP
Plug 'hrsh7th/vim-vsnip-integ'                          " Asyncomplete snippet for LSP

"------------------------------------------------------------------------------------------------
" Language support
"------------------------------------------------------------------------------------------------
Plug 'dense-analysis/ale'                               " Linting engine
Plug 'nickspoons/vim-sharpenup'                         " C# status line options
Plug 'OmniSharp/omnisharp-vim'                          " Default C# intellisense/completion
Plug 'prabirshrestha/vim-lsp'                           " LSP Implementation

"------------------------------------------------------------------------------------------------
" Markdown 
"------------------------------------------------------------------------------------------------
Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() }, 'for': ['markdown', 'vim-plug']}   " Markdown Support

call plug#end()

source ~/.vim/configs/editor.vim
source ~/.vim/configs/lint.vim
source ~/.vim/configs/search.vim
source ~/.vim/configs/explorer.vim
source ~/.vim/configs/format.vim
source ~/.vim/ftplugin/csharp.vim
source ~/.vim/ftplugin/rust.vim
source ~/.vim/configs/statusline.vim
