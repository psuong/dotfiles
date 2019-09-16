" ALE
let g:ale_linters = { 
    \'cs': ['OmniSharp'],
    \'cpp': ['clangd'],
    \'rust': ['rls']
    \}

let g:ale_sign_error = '▲'
let g:ale_sign_warning = '▶'
let g:airline#extensions#ale#enabled = 1

" LSP
let g:lsp_diagnostics_enabled = 0     " disable diagnostics support and offload this to ALE
