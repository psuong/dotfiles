" ---------------------------------------------------------------------
" C# Sharpen Up StatusLine
" ---------------------------------------------------------------------
let g:sharpenup_codeactions_glyph = '->'
let g:sharpenup_statusline_opts = 'O#: •'
set laststatus=3

augroup lightline_integration
  autocmd!
  autocmd User OmniSharpStarted,OmniSharpReady,OmniSharpStopped call lightline#update()
augroup END

" ---------------------------------------------------------------------
" Lightline Settings
" ---------------------------------------------------------------------
let g:lightline = {
    \ 'colorscheme': 'seoul256',
    \ 'active': {
    \   'left': [['readonly', 'filename', 'modified']],
    \   'right': [['lineinfo', 'fileformat', 'fileencoding'], ['sharpenup']]
    \ },
    \ 'inactive': {
    \   'right': [['lineinfo'], ['sharpenup']]
    \ },
    \ 'component': {
    \   'sharpenup': sharpenup#statusline#Build()
    \ }
\}
