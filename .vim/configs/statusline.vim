" ---------------------------------------------------------------------
" C# Sharpen Up StatusLine
" ---------------------------------------------------------------------
let g:sharpenup_codeactions_glyph = '->'
let g:sharpenup_statusline_opts = 'O#: •'

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
    \   'left': [[ 'gitbranch', 'readonly', 'filename', 'modified' ]],
    \   'right': [['lineinfo', 'fileformat', 'fileencoding'], ['sharpenup'], ['lsp_errors', 'lsp_warnings', 'lsp_ok']]
    \ },
    \ 'inactive': {
    \   'right': [['lineinfo'], ['sharpenup']]
    \ },
    \ 'component_function': {
    \    'gitbranch': 'gitbranch#name',
    \ },
    \ 'component': {
    \   'sharpenup': sharpenup#statusline#Build()
    \ },
    \ 'component_expand': {
    \   'lsp_warnings': 'lightline_lsp#warnings',
    \   'lsp_errors':   'lightline_lsp#errors',
    \   'lsp_ok':       'lightline_lsp#ok',
    \ },
    \ 'component_type': {
    \   'lsp_warnings': 'warning',
    \   'lsp_errors':   'error',
    \   'lsp_ok':       'middle',
    \ },
\}
