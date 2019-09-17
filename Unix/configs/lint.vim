" ALE
let g:ale_linters = {
    \'cs': ['OmniSharp'],
    \'rust': ['rls']
    \}

let g:ale_linters_explicit = 1
let g:ale_sign_error = '>>'
let g:ale_sign_warning = '??'
let g:airline#extensions#ale#enabled = 1

" let g:ale_sign_error = '❌'
" let g:ale_sign_warning = '⚠️'

" LSP
let g:lsp_diagnostics_enabled = 1     " enable diagnostics
let g:lsp_signs_enabled = 1           " enable signs
let g:lsp_diagnostics_echo_cursor = 1 " enable echo under cursor when in normal mode
let g:lsp_signs_error = { 'text': '>>' }
let g:lsp_signs_warning = { 'text': '??' }

" let g:lsp_signs_error = {'text': '❌' }
" let g:lsp_signs_warning = { 'text': '⚠️' }
" let g:lsp_signs_hint = { 'text': '💡' }
" ✗