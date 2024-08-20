"------------------------------------------------------------------------------------------------
" Vim Plugins
"------------------------------------------------------------------------------------------------
let g:plug_url_format = 'git@github.com:%s.git'
call plug#begin()

"------------------------------------------------------------------------------------------------
" Editor View
"------------------------------------------------------------------------------------------------
Plug 'ellisonleao/gruvbox.nvim'                                 " Main theme
Plug 'nvim-tree/nvim-web-devicons'                              " Web devicons
Plug 'lambdalisue/glyph-palette.vim'                            " Adds palette colors
Plug 'karb94/neoscroll.nvim'                                    " Smooth scrolling in lua
Plug 'lukas-reineke/indent-blankline.nvim'                      " Blankline indentation
Plug 'romgrk/barbar.nvim'                                       " Tab supports

"------------------------------------------------------------------------------------------------
" Explorer
"------------------------------------------------------------------------------------------------
Plug 'lambdalisue/fern.vim'                                     " Default file explorer
Plug 'TheLeoP/fern-renderer-web-devicons.nvim'                  " Fern with dev icons
Plug 'yuki-yano/fern-preview.vim'                               " Previewing 

"------------------------------------------------------------------------------------------------
" Statusbar
"------------------------------------------------------------------------------------------------
Plug 'itchyny/lightline.vim'                                    " Status bar for Vim
Plug 'shinchu/lightline-gruvbox.vim'                            " Lightline theme
Plug 'maximbaz/lightline-ale'                                   " ALE diagnostic in vim-lsp

"------------------------------------------------------------------------------------------------
" Formats
"------------------------------------------------------------------------------------------------
Plug 'editorconfig/editorconfig-vim'                            " Unified file formats

"------------------------------------------------------------------------------------------------
" Search
"------------------------------------------------------------------------------------------------
Plug 'liuchengxu/vim-clap', { 'do': ':Clap install-binary' }    " Default searcher

"------------------------------------------------------------------------------------------------
" LSP Config
"------------------------------------------------------------------------------------------------
Plug 'neovim/nvim-lspconfig'

"------------------------------------------------------------------------------------------------
" Syntax Highlighting
"------------------------------------------------------------------------------------------------
Plug 'nvim-treesitter/nvim-treesitter', { 'do': ':TSUpdate' }   " Treesitter parsing
Plug 'nvim-treesitter/nvim-treesitter-context'                  " Context showing
Plug 'preservim/tagbar'                                         " Table of contents for functions/variables

"------------------------------------------------------------------------------------------------
" Autocompletion
"------------------------------------------------------------------------------------------------
Plug 'vim-denops/denops.vim'
Plug 'Shougo/ddc.vim'
Plug 'kkoomen/vim-doge', { 'do': { -> doge#install() } }        " Doc generation

"------------------------------------------------------------------------------------------------
" UI
"------------------------------------------------------------------------------------------------
Plug 'Shougo/ddc-ui-native'
Plug 'matsui54/denops-popup-preview.vim'
Plug 'stevearc/dressing.nvim'
Plug 'MunifTanjim/nui.nvim'
Plug 'VonHeikemen/fine-cmdline.nvim'

"------------------------------------------------------------------------------------------------
" Sources
"------------------------------------------------------------------------------------------------
Plug 'Shougo/ddc-source-lsp'
Plug 'matsui54/ddc-source-buffer'
Plug 'tani/ddc-fuzzy'

"------------------------------------------------------------------------------------------------
" Linting
"------------------------------------------------------------------------------------------------
Plug 'dense-analysis/ale'

"------------------------------------------------------------------------------------------------
" Snippets
"------------------------------------------------------------------------------------------------
Plug 'SirVer/ultisnips'
Plug 'matsui54/ddc-ultisnips'
Plug 'honza/vim-snippets'
Plug 'hrsh7th/vim-vsnip'
Plug 'rafamadriz/friendly-snippets'
Plug 'uga-rosa/ddc-source-vsnip'

"------------------------------------------------------------------------------------------------
" Rust Support
"------------------------------------------------------------------------------------------------
Plug 'rust-lang/rust.vim'                                       " Rust Utils
Plug 'nvim-lua/plenary.nvim'                                    " async modules
Plug 'saecki/crates.nvim', { 'tag': 'stable' }                  " Managing crates
Plug 'mrcjkb/rustaceanvim'                                      " Rust power tools

"------------------------------------------------------------------------------------------------
" CSharp Support
"------------------------------------------------------------------------------------------------
Plug 'psuong/omnisharp-vim'                                     " Default C# intellisense/completion
Plug 'gabriel-gardner/ddc-omnisharp-vim'                        " Source configurations
Plug 'nickspoons/vim-sharpenup'                                 " C# status line options

call plug#end()

source ~/AppData/Local/nvim/configs/editor.vim
source ~/AppData/Local/nvim/configs/lint.vim
source ~/AppData/Local/nvim/configs/explorer.vim
