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

" C# Sharpen Up
let g:sharpenup_statusline_opts = {
\ 'TextLoading': ' O#: Loading... ',
\ 'TextReady': ' O#: Ready',
\ 'TextDead': ' O#: ✗ ',
\ 'Highlight': 1,
\ 'HiLoading': 'SharpenUpLoading',
\ 'HiReady': 'SharpenUpReady',
\ 'HiDead': 'SharpenUpDead'
\}

" Replace the glyph
let g:sharpenup_codeactions_glyph = '�'