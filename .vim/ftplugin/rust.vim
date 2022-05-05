" ----------------------------------------------------------------------
" LSP Settings for Rust
" ----------------------------------------------------------------------
augroup rust_commands
    autocmd!

    autocmd FileType rust nmap <silent> <buffer> <Leader>gd :LspDefinition<CR>
    autocmd FileType rust nmap <silent> <buffer> <Leader>pd :LspHover<CR>
    autocmd FileType rust nmap <silent> <buffer> <Leader>fu :LspReferences<CR>
    autocmd FileType rust nmap <silent> <buffer> <Leader>nm :LspRename<CR>
    autocmd FileType rust nmap <silent> <buffer> <Leader>ra :LspCodeAction<CR>
    autocmd FileType rust nmap <silent> <buffer> <Leader>cf :LspDocumentFormatSync<CR>
    autocmd FileType rust nmap <silent> <buffer> <Leader>ne :LspNextError<CR>
    autocmd FileType rust nmap <silent> <buffer> <Leader>nw :LspNextWarning<CR>
    autocmd FileType rust nmap <silent> <buffer> <Leader>pe :LspPreviousError<CR>
    autocmd FileType rust nmap <silent> <buffer> <Leader>pw :LspPreviousWarning<CR>
augroup END
