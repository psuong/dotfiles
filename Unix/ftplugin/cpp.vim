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

" Key bindings for vim-lsp.
nnoremap <Leader>gd :LspDefinition<CR>
nnoremap <Leader>gt :LspDeclaration<CR>
nnoremap <Leader>fu :LspReferences<CR>
nnoremap <Leader>nm :LspRename<CR>
nnoremap <Leader>tt :LspTypeDefinition<CR>
nnoremap <Leader>cf :LspDocumentFormat<CR>
nnoremap <Leader>ra :LspCodeAction<CR>
