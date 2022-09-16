"------------------------------------------------------------------------------------------------
" Vim Plugins
"------------------------------------------------------------------------------------------------
call plug#begin('~/.vim/plugged')

"------------------------------------------------------------------------------------------------
" Editor View
"------------------------------------------------------------------------------------------------
Plug 'sainnhe/gruvbox-material'                         " Gruvbox material design w/ treesitter
Plug 'junegunn/vim-easy-align'                          " Align by expressions
Plug 'itchyny/lightline.vim'                            " Status bar for Vim
Plug 'editorconfig/editorconfig-vim'                    " Unified file formats
Plug 'lambdalisue/fern.vim'                             " Default file explorer
Plug 'equalsraf/neovim-gui-shim'                        " nvim-qt settings
Plug 'karb94/neoscroll.nvim'                            " Smooth scrolling in lua
Plug 'ncm2/float-preview.nvim'                          " Preview window that is floating

"------------------------------------------------------------------------------------------------
" Formats
"------------------------------------------------------------------------------------------------
Plug 'lukas-reineke/indent-blankline.nvim'
Plug 'preservim/tagbar'

"------------------------------------------------------------------------------------------------
" Search
"------------------------------------------------------------------------------------------------
Plug 'liuchengxu/vim-clap', { 'do': ':Clap install-binary' }

"------------------------------------------------------------------------------------------------
" Git
"------------------------------------------------------------------------------------------------
Plug 'lambdalisue/gina.vim'                             " Git integration

"------------------------------------------------------------------------------------------------
" Autocompletion
"------------------------------------------------------------------------------------------------
Plug 'prabirshrestha/asyncomplete.vim'
Plug 'prabirshrestha/asyncomplete-lsp.vim'

"------------------------------------------------------------------------------------------------
" Snippets
"------------------------------------------------------------------------------------------------
Plug 'SirVer/ultisnips'                                 " Snippet support
Plug 'honza/vim-snippets'                               " Common snippets
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}

"------------------------------------------------------------------------------------------------
" Language support
"------------------------------------------------------------------------------------------------
Plug 'dense-analysis/ale'                               " Linting engine
Plug 'OmniSharp/omnisharp-vim'                          " Default C# intellisense/completion
Plug 'nickspoons/vim-sharpenup'                         " C# status line options
Plug 'prabirshrestha/vim-lsp'
Plug 'mattn/vim-lsp-settings'

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
