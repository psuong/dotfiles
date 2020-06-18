" C# Sharpen Up
let g:sharpenup_codeactions_glyph = '�'
let g:sharpenup_statusline_opts = ' 0# ✓ '

" let g:sharpenup_statusline_opts = {
" \ 'TextLoading': ' O#: • ',
" \ 'TextReady': ' O#: ✓ ',
" \ 'TextDead': ' O#: ✘ ',
" \ 'Highlight': 1,
" \ 'HiLoading': 'SharpenUpLoading',
" \ 'HiReady': 'SharpenUpReady',
" \ 'HiDead': 'SharpenUpDead'
" \}

" Lightline Settings
let g:lightline = {
\ 'colorscheme': 'solarized',
\ 'active': {
\   'left': [ [ 'mode', 'paste' ],
\             [ 'cocstatus', 'gitbranch', 'readonly', 'filename', 'modified' ] ],
\   'right': [['lineinfo'], ['fileformat', 'fileencoding', 'sharpenup']]
\ },
\ 'inactive': {
\   'right': [['lineinfo'], ['sharpenup']]
\ },
\ 'component_function': {
\    'gitbranch': 'gitbranch#name',
\    'cocstatus': 'coc#status'
\ },
\ 'component': {
\   'sharpenup': sharpenup#statusline#Build()
\ }
\}

augroup lightline_integration
  autocmd!
  autocmd User OmniSharpStarted,OmniSharpReady,OmniSharpStopped call lightline#update()
augroup END
