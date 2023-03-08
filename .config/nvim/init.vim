"------------------------------------------------------------------------------------------------
" Vim Plugins
"------------------------------------------------------------------------------------------------
call plug#begin('~/.vim/plugged')

"------------------------------------------------------------------------------------------------
" Editor View
"------------------------------------------------------------------------------------------------
Plug 'ellisonleao/gruvbox.nvim', { 'tag' : '1.0.0' }
Plug 'junegunn/vim-easy-align'                          " Align by expressions
Plug 'lambdalisue/fern.vim'                             " Default file explorer
Plug 'equalsraf/neovim-gui-shim'                        " nvim-qt settings
Plug 'karb94/neoscroll.nvim'                            " Smooth scrolling in lua
Plug 'ncm2/float-preview.nvim'                          " Preview window that is floating

"------------------------------------------------------------------------------------------------
" Statusbar
"------------------------------------------------------------------------------------------------
Plug 'itchyny/lightline.vim'                            " Status bar for Vim
Plug 'shinchu/lightline-gruvbox.vim'
Plug 'maximbaz/lightline-ale'                           " ALE diagnostic in vim-lsp
Plug 'halkn/lightline-lsp'                              " vim-lsp lightling integration

"------------------------------------------------------------------------------------------------
" Formats
"------------------------------------------------------------------------------------------------
Plug 'editorconfig/editorconfig-vim'                    " Unified file formats
Plug 'lukas-reineke/indent-blankline.nvim'
Plug 'preservim/tagbar'

"------------------------------------------------------------------------------------------------
" Search
"------------------------------------------------------------------------------------------------
Plug 'liuchengxu/vim-clap', { 'do': ':Clap install-binary' }

"------------------------------------------------------------------------------------------------
" Git
"------------------------------------------------------------------------------------------------

"------------------------------------------------------------------------------------------------
" Autocompletion
"------------------------------------------------------------------------------------------------
Plug 'prabirshrestha/asyncomplete.vim'
Plug 'prabirshrestha/asyncomplete-lsp.vim'

"------------------------------------------------------------------------------------------------
" Snippets
"------------------------------------------------------------------------------------------------
Plug 'SirVer/ultisnips'                                         " Snippet support
Plug 'honza/vim-snippets'                                       " Common snippets
Plug 'prabirshrestha/asyncomplete-ultisnips.vim'                " Autocompletion for support Ultisnips

"------------------------------------------------------------------------------------------------
" Language support
"------------------------------------------------------------------------------------------------
Plug 'dense-analysis/ale'                                       " Linting engine
Plug 'OmniSharp/omnisharp-vim'                                  " Default C# intellisense/completion
Plug 'nickspoons/vim-sharpenup'                                 " C# status line options
Plug 'nvim-treesitter/nvim-treesitter', { 'do': ':TSUpdate' }   " Treesitter parsing
Plug 'prabirshrestha/vim-lsp'                                   " Lsp implementation
Plug 'mattn/vim-lsp-settings'                                   " Common settings

"------------------------------------------------------------------------------------------------
" Markdown 
"------------------------------------------------------------------------------------------------
" Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() }, 'for': ['markdown', 'vim-plug']}   " Markdown Support

call plug#end()

source ~/.vim/configs/editor.vim
source ~/.vim/configs/lint.vim
source ~/.vim/configs/explorer.vim
source ~/.vim/ftplugin/shaders.vim
source ~/.vim/ftplugin/csharp.vim
source ~/.vim/ftplugin/rust.vim
source ~/.vim/configs/statusline.vim
