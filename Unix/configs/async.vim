" Tabbing support
inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
inoremap <expr> <cr>    pumvisible() ? "\<C-y>" : "\<cr>"

" Force refersh
imap <c-space> <Plug>(asyncomplete_force_refresh)

" Don't always show the pop up
let g:asyncomplete_auto_popup = 0

" But we can check for a space for an auto refresh
function! s:check_back_space() abort
    let col = col('.') - 1
    return !col || getline('.')[col - 1]  =~ '\s'
endfunction

" Otherwise we tab and try the refresh
inoremap <silent><expr> <TAB>
  \ pumvisible() ? "\<C-n>" :
  \ <SID>check_back_space() ? "\<TAB>" :
  \ asyncomplete#force_refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

" Close preview menu
autocmd! CompleteDone * if pumvisible() == 0 | pclose | endif