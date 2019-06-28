" ALE
" TODO: Add more linting for C++
let g:ale_linters = { 'cs': ['OmniSharp'],
            \'cpp': ['ccls']
            \}

" LSP
let g:lsp_diagnostics_enabled = 0         " disable diagnostics support
