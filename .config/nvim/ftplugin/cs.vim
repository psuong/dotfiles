echo "Test"
augroup lightline_integration
    autocmd!
    autocmd User OmniSharpStarted,OmniSharpReady,OmniSharpStopped call lightline#update()
augroup END

let g:OmniSharp_want_snippet = 1
let g:OmniSharp_highlighting = 0

" ----------------------------------------------------------------------
" Nvim documenation preview (No popup support)
" ----------------------------------------------------------------------
" Use a preview window instead of echoing it in the cmd line
let g:OmniSharp_typeLookupInPreview = 1
let g:OmniSharp_selector_ui = 'clap'
let g:OmniSharp_selector_findusages = 'clap'

let g:OmniSharp_popup_options = {
\ 'winblend': 0,
\ 'winhl': 'Normal:Normal,FloatBorder:Special',
\ 'border': 'single'
\}

" ----------------------------------------------------------------------
" OmniSharp Server Settings
" -----------------------------------------------------------------------
let g:OmniSharp_server_stdio = 1
let g:Omnisharp_timeout = 5


