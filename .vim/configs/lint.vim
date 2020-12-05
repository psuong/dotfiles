" ALE
" ------------------------------------------------------
let g:ale_linters_explicit = 1

" Rust Analyzer doesn't seem to work so just stick with using RLS
let g:ale_linters = {
    \ 'cs': ['OmniSharp'],
    \ 'rust': ['rls']
\}

let g:ale_sign_column_always = 1
let g:ale_sign_error = '✗'
let g:ale_sign_warning = '!!'

" LSP Settings
" ------------------------------------------------------
let g:lsp_diagnostics_enabled = 0

" LSP Diagnostics Settings
" ------------------------------------------------------
" let g:lsp_signs_enabled = 1
" let g:lsp_signs_error = { 'text': '✗' }
" let g:lsp_signs_warning = { 'text': '!!' }
" let g:lsp_signs_hint = { 'text': '->' }
" let g:lsp_virtual_text_enabled = 0
" let g:lsp_textprop_enabled = 0
" let g:lsp_highlights_enabled = 0
" let g:lsp_highlight_references_enabled = 0
" let g:lsp_diagnostics_echo_cursor = 1

" Allow LSP to fold methods/functions
" ------------------------------------------------------
" set foldmethod=expr
"   \ foldexpr=lsp#ui#vim#folding#foldexpr()
"   \ foldtext=lsp#ui#vim#folding#foldtext()
