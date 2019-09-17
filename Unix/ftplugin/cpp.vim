" Register ccls C++ lanuage server.
if executable('clangd')
    au User lsp_setup call lsp#register_server({
        \ 'name': 'clangd',
        \ 'cmd': {server_info->['clangd', '-background-index']},
        \ 'whitelist': ['c', 'cpp', 'objc', 'objcpp'],
        \ })
endif

" Key bindings for vim-lsp for C based files
autocmd Filetype cpp,c,h,hpp nnoremap <Leader>gd :LspDefinition<CR>
autocmd Filetype cpp,c,h,hpp nnoremap <Leader>gt :LspDeclaration<CR>
autocmd Filetype cpp,c,h,hpp nnoremap <Leader>fu :LspReferences<CR>
autocmd Filetype cpp,c,h,hpp nnoremap <Leader>nm :LspRename<CR>
autocmd Filetype cpp,c,h,hpp nnoremap <Leader>tt :LspTypeDefinition<CR>
autocmd Filetype cpp,c,h,hpp nnoremap <Leader>cf :LspDocumentFormat<CR>
autocmd Filetype cpp,c,h,hpp nnoremap <Leader>ra :LspCodeAction<CR>
autocmd Filetype cpp,c,h,hpp nnoremap <Leader>je :LspPreviousError<CR>
autocmd Filetype cpp,c,h,hpp nnoremap <Leader>ke :LspNextError<CR>
autocmd Filetype cpp,c,h,hpp nnoremap <Leader>pd :LspPeekDefinition<CR>
autocmd Filetype cpp,c,h,hpp nnoremap <Leader>pi :LspPeekImplementation<CR>
autocmd Filetype cpp,c,h,hpp nnoremap <Leader>pt :LspPeekTypeDefinition<CR>
autocmd Filetype cpp,c,h,hpp nnoremap <Leader>pe :LspPeekDeclaration<CR>
autocmd Filetype cpp,c,h,hpp nnoremap <Leader>pm :LspImplementation<CR>
