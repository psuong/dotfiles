" Rust configurations

" LSP Settings for Rust
" ----------------------------------------------------------------------
augroup rust_commands
    autocmd!

    autocmd FileType rust nmap <silent> <buffer> <Leader>gd :LspDefinition<CR>
    autocmd FileType rust nmap <silent> <buffer> <Leader>pd :LspPeekDefinition<CR>
    autocmd FileType rust nmap <silent> <buffer> <Leader>pi :LspHover<CR>
    autocmd FileType rust nmap <silent> <buffer> <Leader>fu :LspReferences<CR>
    autocmd FileType rust nmap <silent> <buffer> <Leader>nm :LspRename<CR>
    autocmd FileType rust nmap <silent> <buffer> <Leader>ra :LspCodeAction<CR>

    autocmd FileType rust nmap <silent> <buffer> <Leader>cf :LspDocumentFormat<CR>
    autocmd FileType rust nmap <silent> <buffer> <Leader>ss :LspStatus<CR>
augroup END
