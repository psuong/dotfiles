" ----------------------------------------------------------------------
" Global ALE
" ----------------------------------------------------------------------
let g:ale_linters_explicit = 1
let g:ale_completion_enabled = 1
let g:ale_sign_column_always = 1
let g:ale_set_balloons = 1
let g:ale_hover_to_preview = 1
let g:ale_floating_preview = 1
let g:ale_sign_error = '->'
let g:ale_sign_warning = '!!'

" Rust Analyzer doesn't to do linting nicely on vim...so using rls 
let g:ale_linters = {
    \ 'cs': ['OmniSharp'],
    \ 'rust': ['rls', 'analyzer']
\}

" ----------------------------------------------------------------------
" Global LSP Settings
" ----------------------------------------------------------------------
let g:lsp_diagnostics_enabled = 0           " Disable diagnostics from LSP
let g:lsp_signs_enabled = 0
let g:lsp_auto_enable = 1

" Disable LSP for C#
let g:lsp_settings = {
    \ 'cs': { 'disabled': v:false },
    \ 'omnisharp-lsp': { 'disabled': v:true }
\}

" ----------------------------------------------------------------------
" Tabbing support
" ----------------------------------------------------------------------
inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
inoremap <expr> <cr>    pumvisible() ? "\<C-y>" : "\<cr>"

autocmd! CompleteDone * if pumvisible() == 0 | pclose | endif

imap <c-r> <Plug>(asyncomplete_force_refresh)

" ----------------------------------------------------------------------
" Snippet support
" ----------------------------------------------------------------------
let g:UltiSnipsExpandTrigger="<c-o>"
if has('python3')
    let g:UltiSnipsExpandTrigger="<c-o>"
    call asyncomplete#register_source(asyncomplete#sources#ultisnips#get_source_options({
        \ 'name': 'ultisnips',
        \ 'whitelist': ['*'],
        \ 'completor': function('asyncomplete#sources#ultisnips#completor'),
        \ }))
endif

" ----------------------------------------------------------------------
" Asyncomplete file source completion
" ----------------------------------------------------------------------
au User asyncomplete_setup call asyncomplete#register_source(asyncomplete#sources#file#get_source_options({
    \ 'name': 'file',
    \ 'whitelist': ['*'],
    \ 'priority': 10,
    \ 'completor': function('asyncomplete#sources#file#completor')
\ }))

