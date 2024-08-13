lua <<EOF
    require('crates').setup()
EOF

lua <<EOF
    require("bacon").setup({
        quickfix  = {
            enabled = true, -- true to populate the quickfix list with bacon errors and warnings
            event_trigger = true, -- triggers the QuickFixCmdPost event after populating the quickfix list
        }
    })
EOF

" ----------------------------------------------------------------------
" LSP Settings for Rust
" ----------------------------------------------------------------------
augroup rust_commands
    autocmd!

    autocmd FileType rust nnoremap ! :BaconLoad<CR>:w<CR>:BaconNext<CR>
    autocmd FileType rust nnoremap , :BaconList<CR>

    autocmd FileType rust nmap <silent> <buffer> gd :LspDefinition<CR>
    autocmd FileType rust nmap <silent> <buffer> <Leader>ra :LspCodeAction<CR>
    autocmd FileType rust nmap <silent> <buffer> <Leader>fu :LspReferences<CR>
    autocmd FileType rust nmap <silent> <buffer> <Leader>cf :LspDocumentFormat<CR>
    autocmd FileType rust nmap <silent> <buffer> <Leader>pd :LspHover<CR>
    autocmd FileType rust nmap <silent> <buffer> <Leader>nm :LspRename<CR>
    autocmd FileType rust nmap <silent> <buffer> <Leader>co :LspOpenCargoToml<CR>
    autocmd FileType rust nmap <silent> <buffer> <Leader>rc :LspCargoReload<CR>
    autocmd FileType rust nmap <silent> <buffer> [[ :LspPreviousError<CR>
    autocmd FileType rust nmap <silent> <buffer> ,, :LspPreviousWarning<CR>
    autocmd FileType rust nmap <silent> <buffer> ]] :LspNextError<CR>
    autocmd FileType rust nmap <silent> <buffer> .. :LspNextWarning<CR>
    autocmd FileType rust nnoremap <C-LeftMouse> :LspDefinition<CR>
    autocmd FileType rust nmap <silent> <buffer> <Leader>rt :RustTest<CR>
    autocmd FileType rust nmap <silent> <buffer> <Leader>ru :RustTest!<CR>

    " ----------------------------------------------------------------------
    " Server Actions
    " ----------------------------------------------------------------------
    autocmd FileType rust nmap <silent> <buffer> <F5> :LspStartServer<CR>
    autocmd FileType rust nmap <silent> <buffer> <F6> :LspStopServer<CR>
    autocmd FileType rust setlocal omnifunc=lsp#complete
augroup END
