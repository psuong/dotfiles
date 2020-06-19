" C# Sharpen Up
let g:sharpenup_codeactions_glyph = '?'
let g:sharpenup_statusline_opts = 'O#: •'

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
