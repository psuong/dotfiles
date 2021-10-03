" ----------------------------------------------------------------------
" Rust LSP configurations
" ---------------------------------------------------------------------
if executable('rust-analyzer')
  au User lsp_setup call lsp#register_server({
    \   'name': 'Rust Language Server',
    \   'cmd': {server_info->['rust-analyzer']},
    \   'whitelist': ['rust'],
    \   'initialization_options': {
    \     'cargo': {
    \       'loadOutDirsFromCheck': v:true,
    \     },
    \     'procMacro': {
    \       'enable': v:true,
    \     },
    \   },
    \ })
endif

" ----------------------------------------------------------------------
" LSP Settings for Rust
" ----------------------------------------------------------------------
augroup rust_commands
    autocmd!

    autocmd FileType rust nmap <silent> <buffer> <Leader>gd :ALEGoToDefinition<CR>
    autocmd FileType rust nmap <silent> <buffer> <Leader>pd :ALEHover<CR>
    autocmd FileType rust nmap <silent> <buffer> <Leader>fu :ALEFindReferences<CR>
    autocmd FileType rust nmap <silent> <buffer> <Leader>nm :ALERename<CR>
    autocmd FileType rust nmap <silent> <buffer> <Leader>ra :ALECodeAction<CR>

    " ----------------------------------------------------------------------
    " Server Actions
    " ----------------------------------------------------------------------
    autocmd FileType rust nmap <silent> <buffer> <F5> :ALEEnable<CR>
    autocmd FileType rust nmap <silent> <buffer> <F6> :ALEDisable<CR>
    autocmd FileType rust nmap <silent> <buffer> <F7> :ALEStopAllLSPs<CR>
augroup END
