" Tabbing support
inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
inoremap <expr> <cr>    pumvisible() ? "\<C-y>" : "\<cr>"

autocmd! CompleteDone * if pumvisible() == 0 | pclose | endif

imap <c-r> <Plug>(asyncomplete_force_refresh)

if has('python3')
    let g:UltiSnipsExpandTrigger="<c-o>"
    " let g:UltiSnipsJumpFowardTrigger="<c-i>"
    " let g:UltiSnipsJumpBackwardTrigger="<c-u>"
    call asyncomplete#register_source(asyncomplete#sources#ultisnips#get_source_options({
        \ 'name': 'ultisnips',
        \ 'whitelist': ['*'],
        \ 'completor': function('asyncomplete#sources#ultisnips#completor'),
        \ }))
endif
