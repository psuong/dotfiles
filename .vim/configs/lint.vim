" ALE
" ------------------------------------------------------
let g:ale_linters = {
    \ 'cs': ['OmniSharp'],
    \ 'rust': ['rls']
\}

let g:ale_linters_explicit = 1
let g:ale_sign_column_always = 1
let g:ale_sign_error = '✗'
let g:ale_sign_warning = '!!'

" LSP Settings
" ------------------------------------------------------
let g:lsp_diagnostics_enabled = 0

" Allow LSP to fold methods/functions
" set foldmethod=expr
"   \ foldexpr=lsp#ui#vim#folding#foldexpr()
"   \ foldtext=lsp#ui#vim#folding#foldtext()
