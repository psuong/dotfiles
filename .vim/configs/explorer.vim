" ----------------------------------------------------------------------
" Fern Settings
" ----------------------------------------------------------------------
let g:fern#mark_symbol                       = '● '
let g:fern#renderer#default#collapsed_symbol = '+ '
let g:fern#renderer#default#expanded_symbol  = '- '
let g:fern#renderer#default#leading          = ' '
let g:fern#renderer#default#leaf_symbol      = ' '
let g:fern#renderer#default#root_symbol      = '~ '

function! s:init_fern() abort
  " ----------------------------------------------------------------
  " Perform expand or collapse
  " ----------------------------------------------------------------
  nmap <buffer><expr>
    \ <Plug>(fern-my-expand-or-collapse)
    \ fern#smart#leaf(
    \   "\<Plug>(fern-action-collapse)",
    \   "\<Plug>(fern-action-expand)",
    \   "\<Plug>(fern-action-collapse)",
    \ )

  nmap <buffer><nowait> <enter> <Plug>(fern-my-expand-or-collapse)
  " ----------------------------------------------------------------
  " Bind opening and closing the fern buffer
  " ----------------------------------------------------------------
  nmap <c-n> :Fern . -drawer -toggle<CR>
  nmap <c-b> :FernDo close<CR>

  " ----------------------------------------------------------------
  " Press o to open the file
  " ----------------------------------------------------------------
  nmap <buffer> o <Plug>(fern-action-open) 
endfunction

augroup fern-custom
  autocmd! *
  autocmd FileType fern call s:init_fern()
augroup END

autocmd vimenter * ++nested Fern . -drawer -toggle

" ----------------------------------------------------------------------
" Vim Clap
" ----------------------------------------------------------------------
nmap <c-p> :Clap files<CR>
let g:clap_layout = { 
    \ 'relative': 'editor'
\ }

autocmd FileType clap_input let g:asyncomplete_auto_popup = 0

augroup VimClapEnterExitGroup
  autocmd!
  autocmd User ClapOnEnter   call DisableAsyncomplete()
  autocmd User ClapOnExit    call EnableAsyncomplete()
augroup END

:function DisableAsyncomplete()
:   let g:asyncomplete_auto_popup = 0
:endfunction

:function EnableAsyncomplete()
:   let g:asyncomplete_auto_popup = 1
:endfunction
