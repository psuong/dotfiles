" Omnisharp key configs

" Syntax Highlighting
" ----------------------------------------------------------------------
" 2: for buffer enter/leave, 3 for any kind of typing
let g:OmniSharp_highlight_types = 2 

" Snippet settings
" ----------------------------------------------------------------------
" Uses Ultisnips to fill out the function params if enabled
let g:OmniSharp_want_snippet = 1

" Nvim documenation preview (No popup support)
" ----------------------------------------------------------------------
" Use a preview window instead of echoing it in the cmd line
let g:OmniSharp_typeLookupInPreview = 1 
let g:OmniSharp_selector_ui = 'fzf'
set completeopt=longest,menuone,preview
set previewheight=5
" set splitbelow

" OmniSharp Server Settings
" -----------------------------------------------------------------------
if has('Unix')
    let lines = readfile("/proc/version")
    if lines[0] =~ "Microsoft"
        let g:OmniSharp_translate_cygwin_wsl = 1
    endif
endif

let g:OmniSharp_server_stdio = 1
let g:Omnisharp_timeout = 5
let g:OmniSharp_server_path = '/mnt/c/Users/Blank/sources/omnisharp-win-x64/OmniSharp.exe'

if has('macunix')
    let g:OmniSharp_server_use_mono = 1
    let g:Omnisharp_server_path = '/Users/psuong/sources/omnisharp-osx/run'
endif

" C# SharpenUp
" -----------------------------------------------------------------------
let g:sharpenup_codeactions_autocmd = 'CursorHold,CursorMoved,BufEnter'

" Popup Options
" -----------------------------------------------------------------------
let g:OmniSharp = {
\ 'popup': {
\   'mappings': {
\     'sigNext': '<C-j>',
\     'sigPrev': '<C-k>',
\     'lineDown': ['<C-e>', 'j'],
\     'lineUp': ['<C-y>', 'k']
\   }
\ }
\}

" OmniSharp pop up support Nvim styling
let g:OmniSharp.popup.options = {
\ 'winblend': 30,
\ 'winhl': 'Normal:Normal'
\}

" Omnisharp commands
" -----------------------------------------------------------------------
augroup omnisharp_commands
    autocmd!

    " New settings START!
    " ---------------------------------------------------------------------

    " Show type information automatically when the cursor stops moving.
    " Note that the type is echoed to the Vim command line, and will overwrite
    " any other messages in this space including e.g. ALE linting messages.
    autocmd CursorHold *.cs OmniSharpTypeLookup

    " Code Actions
    " --------------------------------------------------------------------------
    autocmd FileType cs nmap <silent> <buffer> gd <Plug>(omnisharp_go_to_definition)
    autocmd FileType cs nmap <silent> <buffer> <Leader>fu <Plug>(omnisharp_find_usages)
    autocmd FileType cs nmap <silent> <buffer> <Leader>fi <Plug>(omnisharp_find_implementations)
    autocmd FileType cs nmap <silent> <buffer> <Leader>pd <Plug>(omnisharp_preview_definition)
    autocmd FileType cs nmap <silent> <buffer> <Leader>pi <Plug>(omnisharp_preview_implementations)
    autocmd FileType cs nmap <silent> <buffer> <Leader>td <Plug>(omnisharp_documentation)
    autocmd FileType cs nmap <silent> <buffer> <Leader>fs <Plug>(omnisharp_find_symbol)
    autocmd FileType cs nmap <silent> <buffer> <Leader>fx <Plug>(omnisharp_fix_usings)
    autocmd FileType cs nmap <silent> <buffer> <Leader>ra <Plug>(omnisharp_code_actions)
    autocmd FileType cs xmap <silent> <buffer> <Leader>ra <Plug>(omnisharp_code_actions)
    autocmd FileType cs nmap <silent> <buffer> <Leader>gc <Plug>(omnisharp_global_code_check)

    " Rename
    " --------------------------------------------------------------------------
    autocmd FileType cs nmap <silent> <buffer> <Leader>nm <Plug>(omnisharp_rename)

    " Server Actions
    " --------------------------------------------------------------------------
    autocmd FileType cs nmap <silent> <buffer> <Leader>osre <Plug>(omnisharp_restart_server)
    autocmd FileType cs nmap <silent> <buffer> <Leader>osst <Plug>(omnisharp_start_server)
    autocmd FileType cs nmap <silent> <buffer> <Leader>ossp <Plug>(omnisharp_stop_server)

    " Method Actions
    " --------------------------------------------------------------------------
    autocmd FileType cs nmap <silent> <buffer> [[ <Plug>(omnisharp_navigate_up)
    autocmd FileType cs nmap <silent> <buffer> ]] <Plug>(omnisharp_navigate_down)

    " New settings END
    " ---------------------------------------------------------------------
augroup END
