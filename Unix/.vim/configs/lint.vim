" ALE
let g:ale_linters = {
    \'cs': ['OmniSharp'],
    \'rust': ['rls']
    \}

let g:ale_sign_column_always = 1
let g:ale_sign_error = '✗'
let g:ale_sign_warning = '?'

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
" let g:OmniSharp_translate_cygwin_wsl = 1
" let g:OmniSharp_server_path = '/mnt/c/Users/Blank/omnisharp-win-x64/OmniSharp.exe'

if has('macunix')
    let g:OmniSharp_server_use_mono = 1
    let g:Omnisharp_server_path = '/Users/psuong/sources/omnisharp-osx/run'
endif

" C# SharpenUp
let g:sharpenup_codeactions_autocmd = 'CursorHold,CursorMoved,BufEnter'

" Rust 
autocmd User asyncomplete_setup call asyncomplete#register_source(
    \ asyncomplete#sources#racer#get_source_options())

" Vim Blamer
let g:blamer_enabled = 1