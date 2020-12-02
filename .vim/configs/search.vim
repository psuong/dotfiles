" Fuzzy Finder
" -------------------------------------------------------------------------------
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

let g:fzf_layout = { 'window': 'enew' }
let g:fzf_layout = { 'window': '-tabnew' }
let g:fzf_layout = { 'window': '10new' }

" Unix Preview Settings
" -------------------------------------------------------------------------------
" So this is pretty laggy on WSL disabling it by default even though it's cool
nnoremap <c-p> :FZF! --preview=head\ -50\ {}<CR>

" Default no preview
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
