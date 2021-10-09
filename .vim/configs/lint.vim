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
" Global LSP
" ----------------------------------------------------------------------
let g:lsp_diagnostics_signs_delay = 0
let g:lsp_diagnostics_virtual_text_enabled = 1
let g:lsp_diagnostics_signs_error = {'text': '✗'}
let g:lsp_diagnostics_signs_warning = {'text': '‼'}
let g:lsp_diagnostics_signs_hint = {'text': '?'}
let g:lsp_document_code_action_signs_hint = {'text': '?'}
let g:lsp_document_code_action_signs_delay = 0
let g:lsp_document_highlights_enabled = 0
let g:lsp_diagnostics_highlights_enabled = 0
let g:lsp_diagnostics_highlights_insert_mode_enabled = 0

" ----------------------------------------------------------------------
" Asyncomplete register sources
" ----------------------------------------------------------------------
au User asyncomplete_setup call asyncomplete#register_source(asyncomplete#sources#ale#get_source_options({
  \ 'priority': 10,
  \ }))

" ----------------------------------------------------------------------
" Tabbing support
" ----------------------------------------------------------------------
inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
inoremap <expr> <cr>    pumvisible() ? "\<C-y>" : "\<cr>"

autocmd! CompleteDone * if pumvisible() == 0 | pclose | endif

imap <c-r> <Plug>(asyncomplete_force_refresh)

" ----------------------------------------------------------------------
" Snippet support
" ----------------------------------------------------------------------
if has('python3')
    let g:UltiSnipsExpandTrigger="<c-o>"
    call asyncomplete#register_source(asyncomplete#sources#ultisnips#get_source_options({
        \ 'name': 'ultisnips',
        \ 'whitelist': ['*'],
        \ 'completor': function('asyncomplete#sources#ultisnips#completor'),
        \ }))
endif

" ----------------------------------------------------------------------
" NOTE: You can use other key to expand snippet.
" ----------------------------------------------------------------------
" Expand
imap <expr> <C-j>   vsnip#expandable()  ? '<Plug>(vsnip-expand)'         : '<C-j>'
smap <expr> <C-j>   vsnip#expandable()  ? '<Plug>(vsnip-expand)'         : '<C-j>'

" Expand or jump
imap <expr> <C-l>   vsnip#available(1)  ? '<Plug>(vsnip-expand-or-jump)' : '<C-l>'
smap <expr> <C-l>   vsnip#available(1)  ? '<Plug>(vsnip-expand-or-jump)' : '<C-l>'

" Jump forward or backward
" imap <expr> <C-k> vsnip#jumpable(1)   ? '<Plug>(vsnip-jump-next)'      : '<C-k>'
" smap <expr> <C-k> vsnip#jumpable(1)   ? '<Plug>(vsnip-jump-next)'      : '<C-k>'
" imap <expr> <S-k> vsnip#jumpable(-1)  ? '<Plug>(vsnip-jump-prev)'      : '<S-k>'
" smap <expr> <S-k> vsnip#jumpable(-1)  ? '<Plug>(vsnip-jump-prev)'      : '<S-k>'

" Select or cut text to use as $TM_SELECTED_TEXT in the next snippet.
" See https://github.com/hrsh7th/vim-vsnip/pull/50
nmap        s   <Plug>(vsnip-select-text)
xmap        s   <Plug>(vsnip-select-text)
nmap        S   <Plug>(vsnip-cut-text)
xmap        S   <Plug>(vsnip-cut-text)