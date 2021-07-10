" ----------------------------------------------------------------------
" Fuzzy Finder
" ----------------------------------------------------------------------
let g:fzf_action = {
    \ 'ctrl-s': 'split',
    \ 'ctrl-v': 'vsplit'
    \ }

let g:fzf_colors =
\ { 'fg':      ['fg', 'Normal'],
  \ 'bg':      ['bg', 'Normal'],
  \ 'hl':      ['bg', 'Statement'],
  \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
  \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
  \ 'hl+':     ['fg', 'Statement'],
  \ 'info':    ['fg', 'Exception'],
  \ 'border':  ['fg', 'Ignore'],
  \ 'prompt':  ['fg', 'Exception'],
  \ 'pointer': ['fg', 'Exception'],
  \ 'marker':  ['fg', 'Keyword'],
  \ 'spinner': ['fg', 'Statement'],
  \ 'header':  ['fg', 'Comment'] }

let g:fzf_layout = { 'window': { 'width': 0.9, 'height': 0.6 } }

" ----------------------------------------------------------------------
" Default no preview
" ----------------------------------------------------------------------
nnoremap <c-p> :FZF<CR>

" ----------------------------------------------------------------------
" Preview settings, requires batcat
" ----------------------------------------------------------------------
" if has('Unix')
"     nnoremap <c-p> :FZF<CR>
" elseif has('Windows')
"     nnoremap <c-p> :FZF! --preview=bat\ {}<CR>
" endif

augroup fzf
  autocmd!
  autocmd! FileType fzf
  autocmd  FileType fzf set laststatus=0 noshowmode noruler
    \| autocmd BufLeave <buffer> set laststatus=2 showmode ruler
augroup END
