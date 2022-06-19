"------------------------------------------------------------------------------------------------
" Vim Plugins
"------------------------------------------------------------------------------------------------
call plug#begin('~/.vim/plugged')

"------------------------------------------------------------------------------------------------
" Editor View
"------------------------------------------------------------------------------------------------
" Plug 'gruvbox-community/gruvbox'                        " Gruvbox
Plug 'ellisonleao/gruvbox.nvim'                         " Gruvbox with treesitter
Plug 'junegunn/vim-easy-align'                          " Align by expressions
Plug 'itchyny/lightline.vim'                            " Status bar for Vim
Plug 'editorconfig/editorconfig-vim'                    " Unified file formats
Plug 'lambdalisue/fern.vim'                             " Default file explorer
Plug 'equalsraf/neovim-gui-shim'                        " nvim-qt settings
Plug 'josa42/vim-lightline-coc'                         " coc status line options
Plug 'nickspoons/vim-sharpenup'                         " C# status line options
"------------------------------------------------------------------------------------------------
" Formats
"------------------------------------------------------------------------------------------------
Plug 'lukas-reineke/indent-blankline.nvim'

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
Plug 'neoclide/coc.nvim', {'branch': 'release'}         " Default autocomplete

"------------------------------------------------------------------------------------------------
" Snippets
"------------------------------------------------------------------------------------------------
Plug 'SirVer/ultisnips'                                 " Snippet support
Plug 'honza/vim-snippets'                               " Common snippets
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'wellle/context.vim'

"------------------------------------------------------------------------------------------------
" Language support
"------------------------------------------------------------------------------------------------
Plug 'dense-analysis/ale'                               " Linting engine
Plug 'OmniSharp/omnisharp-vim'                          " Default C# intellisense/completion

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
