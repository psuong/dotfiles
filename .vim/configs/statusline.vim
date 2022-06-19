" ---------------------------------------------------------------------
" C# Sharpen Up StatusLine
" ---------------------------------------------------------------------
let g:sharpenup_codeactions_glyph = '->'
let g:sharpenup_statusline_opts = 'O#: █'

set laststatus=3

augroup lightline_integration
  autocmd!
  autocmd User OmniSharpStarted,OmniSharpReady,OmniSharpStopped call lightline#update()
augroup END


" left': [[  'coc_info', 'coc_hints', 'coc_errors', 'coc_warnings', 'coc_ok' ], [ 'coc_status'  ]]
" ---------------------------------------------------------------------
" Lightline Settings
" ---------------------------------------------------------------------
let g:lightline = {
    \ 'colorscheme': 'seoul256',
    \ 'active': {
    \   'left': [['readonly', 'filename', 'modified']],
    \   'right': [['lineinfo', 'fileformat', 'fileencoding'], ['sharpenup'], 
    \            ['coc_info', 'coc_hints', 'coc_errors', 'coc_warnings', 'coc_ok', 'coc_status']]
    \ },
    \ 'inactive': {
    \   'right': [['lineinfo'], ['sharpenup']]
    \ },
    \ 'component_function': {
    \   'cocstatus': 'coc#status'
    \ },
    \ 'component': {
    \   'sharpenup': sharpenup#statusline#Build()
    \ }
\}

call lightline#coc#register()
