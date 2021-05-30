" ----------------------------------------------------------------------
" Rust configurations
" ----------------------------------------------------------------------

" ----------------------------------------------------------------------
" LSP Rust configuration
" ----------------------------------------------------------------------
if executable('rust-analyzer')
    au User lsp_setup call lsp#register_server({
        \ 'name': 'Rust Language Server (Rust-Analyzer)',
        \ 'cmd': {server_info->['rust-analyzer']},
        \ 'whitelist': ['rust'],
        \ 'initialization_options': {
        \   'cargo': {
        \     'loadOutDirsFromCheck': v:true,
        \   },
        \   'procMacro': {
        \     'enable': v:true,
        \   },
        \ },
    \ })
endif

" ----------------------------------------------------------------------
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

    " ----------------------------------------------------------------------
    " Server Actions
    " ----------------------------------------------------------------------
    autocmd FileType rust nmap <silent> <buffer> <F5> :LspStatus<CR>
    autocmd FileType rust nmap <silent> <buffer> <F7> :LspStopServer<CR>
augroup END
