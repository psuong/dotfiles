" ----------------------------------------------------------------------
" LSP Settings for Rust
" ----------------------------------------------------------------------
augroup rust_commands
    autocmd!

    autocmd FileType rust nmap <silent> <buffer> gd :LspDefinition<CR>
    autocmd FileType rust nmap <silent> <buffer> <Leader>ra :LspCodeAction<CR>
    autocmd FileType rust nmap <silent> <buffer> <Leader>fu :LspReferences<CR>
    autocmd FileType rust nmap <silent> <buffer> <Leader>cf :LspDocumentFormat<CR>
    autocmd FileType rust nmap <silent> <buffer> <Leader>pd :LspHover<CR>
    autocmd FileType rust nmap <silent> <buffer> <Leader>nm :LspRename<CR>
    autocmd FileType rust nmap <silent> <buffer> <Leader>co :LspOpenCargoToml<CR>
    autocmd FileType rust nmap <silent> <buffer> <Leader>rc :LspCargoReload<CR>
    autocmd FileType rust nmap <silent> <buffer> [[ :LspPreviousError<CR>
    autocmd FileType rust nmap <silent> <buffer> ]] :LspNextError<CR>

    " ----------------------------------------------------------------------
    " Server Actions
    " ----------------------------------------------------------------------
    autocmd FileType rust nmap <silent> <buffer> <F5> :LspStartServer<CR>
    autocmd FileType rust nmap <silent> <buffer> <F6> :LspStopServer<CR>

augroup END
