" Register ccls C++ lanuage server.
if executable('ccls')
   au User lsp_setup call lsp#register_server({
      \ 'name': 'ccls',
      \ 'cmd': {server_info->['ccls']},
      \ 'root_uri': {server_info->lsp#utils#path_to_uri(lsp#utils#find_nearest_parent_file_directory(lsp#utils#get_buffer_path(), 'compile_commands.json'))},
      \ 'initialization_options': {'cache': {'directory': '/tmp/ccls/cache' }},
      \ 'whitelist': ['c', 'cpp', 'objc', 'objcpp', 'cc'],
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
