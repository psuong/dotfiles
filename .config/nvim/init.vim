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
Plug 'psliwka/vim-smoothie'                             " Adds some butterly smooth scrolling
Plug 'lambdalisue/fern.vim'                             " Default file explorer
Plug 'equalsraf/neovim-gui-shim'

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
" Plug 'lambdalisue/gina.vim'                             " Git integration
Plug 'vim-denops/denops.vim'
Plug 'lambdalisue/gin.vim'

"------------------------------------------------------------------------------------------------
" Autocompletion
"------------------------------------------------------------------------------------------------
Plug 'prabirshrestha/async.vim'                         " Base autocompletion
Plug 'prabirshrestha/asyncomplete.vim'                  " Autocompletion Engine
Plug 'prabirshrestha/asyncomplete-file.vim'             " File completion
Plug 'prabirshrestha/asyncomplete-lsp.vim'              " Asyncomplete LSP
Plug 'mattn/vim-lsp-settings'                           " Common LSP settings

"------------------------------------------------------------------------------------------------
" Snippets
"------------------------------------------------------------------------------------------------
Plug 'prabirshrestha/asyncomplete-ultisnips.vim'        " Ultisnips support
Plug 'SirVer/ultisnips'                                 " Snippet support
Plug 'honza/vim-snippets'                               " Common snippets
Plug 'hrsh7th/vim-vsnip'                                " Snippet support for LSP
Plug 'hrsh7th/vim-vsnip-integ'                          " Asyncomplete snippet for LSP
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'nvim-treesitter/nvim-treesitter-context'

"------------------------------------------------------------------------------------------------
" Language support
"------------------------------------------------------------------------------------------------
Plug 'dense-analysis/ale'                               " Linting engine
Plug 'nickspoons/vim-sharpenup'                         " C# status line options
Plug 'OmniSharp/omnisharp-vim'                          " Default C# intellisense/completion
Plug 'prabirshrestha/vim-lsp'                           " LSP Implementation
Plug 'halkn/lightline-lsp'
Plug 'beyondmarc/hlsl.vim'                              " HLSL syntax highlighting

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
