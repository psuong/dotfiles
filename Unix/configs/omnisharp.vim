" OmniSharp configs that need to load before ftplugin
let g:OmniSharp_server_stdio = 1        " Use the Stdio server
let g:Omnisharp_timeout=5               " Timeout in 5 seconds
set previewheight=5                     " Set the preview height to 5 units
set splitbelow                          " Put the preview on the bottom
set completeopt=longest,menuone,preview " Enable documentations and previews to show
let g:OmniSharp_typeLookupInPreview = 1 " Use a preview window instead of echoing it in the cmd line
let g:OmniSharp_selector_ui='fzf'       " Use fzf by default
let g:OmniSharp_highlight_types = 2     " Self explanatory
let g:OmniSharp_want_snippet = 1        " Uses Ultisnips to fill out the function params

" WSL Stuff (Disabled by default)
let g:OmniSharp_translate_cygwin_wsl = 1
let g:OmniSharp_server_path = '/mnt/c/Users/Blank/omnisharp-win-x64/OmniSharp.exe'

" C# SharpenUp
let g:sharpenup_statusline_opts = {
\ 'TextLoading': ' O#: Loading... ',
\ 'TextReady': ' O# ',
\ 'TextDead': ' O#: Not running ',
\ 'Highlight': 1,
\ 'HiLoading': 'SharpenUpLoading',
\ 'HiReady': 'SharpenUpReady',
\ 'HiDead': 'SharpenUpDead'
\}

" let g:sharpenup_stausline_opts = { 'Highlight': 0 }
let g:sharpenup_statusline_opts = '•'
highlight SharpenUpReady ctermfg=66 guifg=#458588
" let g:sharpenup_codeactions_autocmd = ['CursorHold', 'CursorMoved']

augroup lightline_integration
    autocmd!
    autocmd User OmniSharpStarted,OmniSharpReady,OmniSharpStopped call lightline#update()
augroup END
