" Fuzzy Finder
" -------------------------------------------------------------------------------
let g:fzf_action = {
    \ 'ctrl-s': 'split',
    \ 'ctrl-v': 'vsplit'
    \ }

" Unix Preview Settings
" -------------------------------------------------------------------------------
" So this is pretty laggy on WSL disabling it by default even though it's cool
nnoremap <c-p> :FZF --preview=head\ -50\ {}<CR>

" Default no preview ):
" nnoremap <c-p> :FZF<CR>

" Windows Preview Settings
" -------------------------------------------------------------------------------
" nnoremap <c-p> :FZF --preview=cat\ {}<CR>

augroup fzf
  autocmd!
  autocmd! FileType fzf
  autocmd  FileType fzf set laststatus=0 noshowmode noruler
    \| autocmd BufLeave <buffer> set laststatus=2 showmode ruler
augroup END
