" ----------------------------------------------------------------------
" Global ALE
" ----------------------------------------------------------------------
let g:ale_linters_explicit = 1
let g:ale_sign_error = '->'
let g:ale_sign_warning = '‼'
let g:ale_sign_info = '·'
let g:ale_sign_style_error = '·'
let g:ale_sign_style_warning = '·'
let g:ale_linters = {
    \ 'cs': ['OmniSharp'],
\}

"" ----------------------------------------------------------------------
" Global vim-lsp Settings
" ----------------------------------------------------------------------
let g:lsp_settings_enable_suggestions = 0
let g:lsp_document_code_action_signs_hint = { 'text': '?' }
let g:lsp_diagnostics_signs_error = { 'text': '->' }
let g:lsp_diagnostics_signs_warning = { 'text': '‼' }
let g:lsp_diagnostics_signs_hint = { 'text': '-' }
let g:lsp_diagnostics_virtual_text_delay = 0
let g:lsp_document_code_action_signs_delay = 0
let g:lsp_inlay_hints_delay = 0
let g:lsp_document_code_action_signs_delay = 0

" ----------------------------------------------------------------------
" Autocompletion
" ----------------------------------------------------------------------
let g:float_preview#docked = 0
let g:asyncomplete_auto_completeopt = 0
set completeopt=menuone,noinsert,noselect

let g:asyncomplete_auto_popup = 1
let g:asyncomplete_auto_completeopt = 0

" ----------------------------------------------------------------------
" Tabbing support
" ----------------------------------------------------------------------
inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
inoremap <expr> <cr>    pumvisible() ? "\<C-y>" : "\<cr>"

autocmd! CompleteDone * if pumvisible() == 0 | pclose | endif

imap <c-space> <Plug>(asyncomplete_force_refresh)

" ----------------------------------------------------------------------
" Snippet support
" ----------------------------------------------------------------------
if has('python3')
    let g:UltiSnipsExpandTrigger="<c-o>"
    let g:UltiSnipsJumpForwardTrigger="<c-j>"
    let g:UltiSnipsJumpBackwardTrigger="<c-k>"
    call asyncomplete#register_source(asyncomplete#sources#ultisnips#get_source_options({
      \ 'name': 'ultisnips',
      \ 'allowlist': ['*'],
      \ 'completor': function('asyncomplete#sources#ultisnips#completor'),
      \ }))
endif

" ----------------------------------------------------------------------
" Treesitter syntax highlighting
" ----------------------------------------------------------------------
lua <<EOF
  require('neoscroll').setup()
  require 'nvim-treesitter.install'.compilers = { "clang", "gcc" }
  require'nvim-treesitter.configs'.setup {
    -- A list of parser names, or "all"
    ensure_installed = { "c", "c_sharp", "rust", "hlsl", "glsl" },

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
nmap <c-]> :TagbarToggle<CR>

" ----------------------------------------------------------------------
" Filetype extensions
" ----------------------------------------------------------------------
au! BufRead,BufNewFile *.shader setfiletype glsl

