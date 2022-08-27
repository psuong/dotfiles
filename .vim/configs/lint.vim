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

" ----------------------------------------------------------------------
" Tabbing support
" ----------------------------------------------------------------------
" use <tab> for trigger completion and navigate to the next complete item
function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~ '\s'
endfunction

inoremap <silent><expr> <Tab>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<Tab>" :
      \ coc#refresh()

inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

" Confirm by pressing enter
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm() : 
    \"\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

" Use <c-space> to trigger completion.
if has('nvim')
  inoremap <silent><expr> <c-space> coc#refresh()
endif

" ----------------------------------------------------------------------
" Snippet support
" ----------------------------------------------------------------------
if has('python3')
    let g:UltiSnipsExpandTrigger="<c-o>"
    " Use <C-l> for trigger snippet expand.
    imap <C-l> <Plug>(coc-snippets-expand)
    " Use <C-j> for select text for visual placeholder of snippet.
    vmap <C-j> <Plug>(coc-snippets-select)
    " Use <C-j> for both expand and jump (make expand higher priority.)
    imap <C-j> <Plug>(coc-snippets-expand-jump)
    " Use <leader>x for convert visual selected code to snippet
    xmap <leader>x  <Plug>(coc-convert-snippet)
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
