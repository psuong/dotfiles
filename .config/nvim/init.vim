"------------------------------------------------------------------------------------------------
" Vim Plugins
"------------------------------------------------------------------------------------------------
let g:plug_url_format = 'git@github.com:%s.git'
call plug#begin('~/.vim/plugged')

"------------------------------------------------------------------------------------------------
" Editor View
"------------------------------------------------------------------------------------------------
Plug 'ellisonleao/gruvbox.nvim'                                             " Main theme
Plug 'nvim-tree/nvim-web-devicons'                                          " Web devicons
Plug 'junegunn/vim-easy-align'                                              " Align by expressions
Plug 'lambdalisue/glyph-palette.vim'                                        " Adds palette colors
Plug 'karb94/neoscroll.nvim'                                                " Smooth scrolling in lua
Plug 'ncm2/float-preview.nvim'                                              " Preview window that is floating

"------------------------------------------------------------------------------------------------
" Tabs
"------------------------------------------------------------------------------------------------
Plug 'romgrk/barbar.nvim'                                                   " Tab supports

"------------------------------------------------------------------------------------------------
" Explorer
"------------------------------------------------------------------------------------------------
Plug 'lambdalisue/fern.vim'                                                 " Default file explorer
Plug 'TheLeoP/fern-renderer-web-devicons.nvim'                              " Fern with dev icons
Plug 'yuki-yano/fern-preview.vim'                                           " Previewing 

"------------------------------------------------------------------------------------------------
" Statusbar
"------------------------------------------------------------------------------------------------
" Plug 'itchyny/lightline.vim'                                              " Status bar for Vim
" Plug 'shinchu/lightline-gruvbox.vim'                                      " Lightline theme
" Plug 'maximbaz/lightline-ale'                                             " ALE diagnostic in vim-lsp
" Plug 'halkn/lightline-lsp'                                                " vim-lsp lightling integration

"------------------------------------------------------------------------------------------------
" Formats
"------------------------------------------------------------------------------------------------
Plug 'editorconfig/editorconfig-vim'                                        " Unified file formats
Plug 'lukas-reineke/indent-blankline.nvim'                                  " Blankline indentation
Plug 'preservim/tagbar'                                                     " Tagbar

"------------------------------------------------------------------------------------------------
" Search
"------------------------------------------------------------------------------------------------
Plug 'liuchengxu/vim-clap', { 'do': ':Clap install-binary' }                " Default searcher

"------------------------------------------------------------------------------------------------
" Git
"------------------------------------------------------------------------------------------------

"------------------------------------------------------------------------------------------------
" Autocompletion
"------------------------------------------------------------------------------------------------
Plug 'prabirshrestha/asyncomplete.vim'                                      " Autocomplete engine
Plug 'prabirshrestha/asyncomplete-lsp.vim'                                  " Default autocomplete for lsp
Plug 'kkoomen/vim-doge', { 'do': { -> doge#install() } }                    " Doc generation


"------------------------------------------------------------------------------------------------
" Snippets
"------------------------------------------------------------------------------------------------
Plug 'SirVer/ultisnips'                                                     " Snippet support
Plug 'honza/vim-snippets'                                                   " Common snippets
Plug 'prabirshrestha/asyncomplete-ultisnips.vim'                            " Autocompletion for support Ultisnips

"------------------------------------------------------------------------------------------------
" Language support
"------------------------------------------------------------------------------------------------
Plug 'dense-analysis/ale'                                                   " Linting engine
Plug 'OmniSharp/omnisharp-vim'                                              " Default C# intellisense/completion
Plug 'nickspoons/vim-sharpenup'                                             " C# status line options
Plug 'nvim-treesitter/nvim-treesitter', { 'do': ':TSUpdate' }               " Treesitter parsing
Plug 'nvim-treesitter/nvim-treesitter-context'                              " Context showing
Plug 'prabirshrestha/vim-lsp'                                               " Lsp implementation
Plug 'mattn/vim-lsp-settings'                                               " Common settings
Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app && npx --yes yarn install' }

call plug#end()

source ~/.vim/configs/editor.vim
source ~/.vim/configs/lint.vim
source ~/.vim/configs/explorer.vim
source ~/.vim/ftplugin/shaders.vim
source ~/.vim/ftplugin/csharp.vim
source ~/.vim/ftplugin/rust.vim
source ~/.vim/configs/statusline.vim
