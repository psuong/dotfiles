if executable('rls')
    au User lsp_setup call lsp#register_server({
        \ 'name': 'rls',
        \ 'cmd': {server_info->['rustup', 'run', 'stable', 'rls']},
        \ 'workspace_config': {'rust': {'clippy_preference': 'on'}},
        \ 'whitelist': ['rust'],
        \ })
endif

autocmd Filetype rs nnoremap <Leader>gd :LspDefinition<CR>
autocmd Filetype rs nnoremap <Leader>gt :LspDeclaration<CR>
autocmd Filetype rs nnoremap <Leader>fu :LspReferences<CR>
autocmd Filetype rs nnoremap <Leader>nm :LspRename<CR>
autocmd Filetype rs nnoremap <Leader>tt :LspTypeDefinition<CR>
autocmd Filetype rs nnoremap <Leader>cf :LspDocumentFormat<CR>
autocmd Filetype rs nnoremap <Leader>ra :LspCodeAction<CR>
autocmd Filetype rs nnoremap <Leader>je :LspPreviousError<CR>
autocmd Filetype rs nnoremap <Leader>ke :LspNextError<CR>
