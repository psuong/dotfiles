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
Plug 'lambdalisue/glyph-palette.vim'                                        " Adds palette colors
Plug 'karb94/neoscroll.nvim'                                                " Smooth scrolling in lua
" Plug 'ncm2/float-preview.nvim'                                              " Preview window that is floating
Plug 'itchyny/vim-cursorword'                                               " Underlines the current word and occurences

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
Plug 'itchyny/lightline.vim'                                              " Status bar for Vim
Plug 'shinchu/lightline-gruvbox.vim'                                      " Lightline theme
Plug 'maximbaz/lightline-ale'                                             " ALE diagnostic in vim-lsp
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
Plug 'SirVer/ultisnips'
Plug 'prabirshrestha/async.vim'
Plug 'prabirshrestha/vim-lsp'
Plug 'thomasfaingnaert/vim-lsp-snippets'
Plug 'thomasfaingnaert/vim-lsp-ultisnips'

"------------------------------------------------------------------------------------------------
" Language support
"------------------------------------------------------------------------------------------------
Plug 'dense-analysis/ale'                                                   " Linting engine
Plug 'prabirshrestha/vim-lsp'                                               " Lsp implementation
Plug 'rhysd/vim-lsp-ale'                                                    " Config between vim-lsp & ale
Plug 'mattn/vim-lsp-settings'                                               " Common settings
Plug 'nvim-treesitter/nvim-treesitter', { 'do': ':TSUpdate' }               " Treesitter parsing
Plug 'nvim-treesitter/nvim-treesitter-context'                              " Context showing

"------------------------------------------------------------------------------------------------
" Rust Support
"------------------------------------------------------------------------------------------------
Plug 'rust-lang/rust.vim'                                                   " Rust Utils
Plug 'nvim-lua/plenary.nvim'                                                " async modules
Plug 'saecki/crates.nvim', { 'tag': 'stable' }                              " Managing crates

"------------------------------------------------------------------------------------------------
" CSharp Support
"------------------------------------------------------------------------------------------------
Plug 'OmniSharp/omnisharp-vim'                                              " Default C# intellisense/completion
Plug 'nickspoons/vim-sharpenup'                                             " C# status line options

"------------------------------------------------------------------------------------------------
" Markdown Support
"------------------------------------------------------------------------------------------------
Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app && npx --yes yarn install' }

call plug#end()

source ~/.vim/configs/editor.vim
source ~/.vim/configs/lint.vim
source ~/.vim/configs/explorer.vim
source ~/.vim/ftplugin/shaders.vim
source ~/.vim/ftplugin/csharp.vim
source ~/.vim/ftplugin/rust.vim
source ~/.vim/ftplugin/uxml.vim
