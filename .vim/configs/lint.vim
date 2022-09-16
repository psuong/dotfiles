" ----------------------------------------------------------------------
" Global ALE
" ----------------------------------------------------------------------
let g:ale_linters_explicit = 1
let g:ale_sign_error = '->'
let g:ale_sign_warning = '‼'
let g:ale_linters = {
    \ 'cs': ['OmniSharp'],
\}

" ----------------------------------------------------------------------
" Autocompletion
" ----------------------------------------------------------------------
set updatetime=300

let g:asyncomplete_auto_completeopt = 0
set completeopt=menuone,noinsert,noselect

" ----------------------------------------------------------------------
" Tabbing support
" ----------------------------------------------------------------------
inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
inoremap <expr> <cr>    pumvisible() ? asyncomplete#close_popup() : "\<cr>"

imap <c-space> <Plug>(asyncomplete_force_refresh)
autocmd! CompleteDone * if pumvisible() == 0 | pclose | endif

" ----------------------------------------------------------------------
" Snippet support
" ----------------------------------------------------------------------
if has('python3')
    let g:UltiSnipsExpandTrigger="<c-o>"
endif

" ----------------------------------------------------------------------
" Treesitter syntax highlighting
" ----------------------------------------------------------------------
lua <<EOF
  require('neoscroll').setup()
  require 'nvim-treesitter.install'.compilers = { "clang", "gcc" }
  require'nvim-treesitter.configs'.setup {
    -- A list of parser names, or "all"
    ensure_installed = { "c", "c_sharp", "rust" },

    -- Install parsers synchronously (only applied to `ensure_installed`)
    sync_install = false,

    highlight = {
      -- `false` will disable the whole extension
      enable = true,
      -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
      -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
      -- Using this option may slow down your editor, and you may see some duplicate highlights.
      -- Instead of true it can also be a list of languages
      additional_vim_regex_highlighting = false,
    },
  }
EOF

" ----------------------------------------------------------------------
" Tagbar
" ----------------------------------------------------------------------
nmap <C-8> :TagbarToggle<CR>
nmap <C-9> :TagbarTogglePause<CR>
