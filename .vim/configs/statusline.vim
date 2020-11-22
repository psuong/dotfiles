" C# Sharpen Up StatusLine
" ---------------------------------------------------------------------
let g:sharpenup_codeactions_glyph = '->'
let g:sharpenup_statusline_opts = 'O#: •'

augroup lightline_integration
  autocmd!
  autocmd User OmniSharpStarted,OmniSharpReady,OmniSharpStopped call lightline#update()
augroup END

" Lightline Settings
" ---------------------------------------------------------------------
let g:lightline = {
\ 'colorscheme': 'codedark',
\ 'active': {
\   'left': [ [ 'mode', 'paste' ],
\             [ 'gitbranch', 'readonly', 'filename', 'modified' ] ],
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
