" NVIM Interface
let $NVIM_PYTHON_LOG_FILE="/tmp/nvim_log"
let $NVIM_PYTHON_LOG_LEVEL="DEBUG"

" Deoplete
let g:deoplete#enable_at_startup = 1    " Enable start up

" Deoplete Tab Completion
" inoremap <silent><expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
inoremap <silent><expr> <TAB>
            \ pumvisible() ? "\<C-n>" :
            \ <SID>check_back_space() ? "\<TAB>" :
            \ deoplete#mappings#manual_complete()
function! s:check_back_space() abort "{{{
    let col = col('.') - 1
    return !col || getline('.')[col - 1]  =~ '\s'
endfunction"}}}

inoremap <silent><expr><S-TAB>  pumvisible() ? "\<C-p>" : "\<TAB>"

inoremap <expr><C-h>
            \ deoplete#smart_close_popup()."\<C-h>"
inoremap <expr><BS>
            \ deoplete#smart_close_popup()."\<C-h>"
