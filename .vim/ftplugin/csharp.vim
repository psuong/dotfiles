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

" ----------------------------------------------------------------------
" C# SharpenUp
" ----------------------------------------------------------------------
let g:sharpenup_statusline_opts = {
\ 'TextLoading': ' O#: %s loading... (%p of %P) ',
\ 'TextReady': ' O#: %s ',
\ 'TextDead': ' O#: Not running ',
\ 'Highlight': 1,
\ 'HiLoading': 'SharpenUpLoading',
\ 'HiReady': 'SharpenUpReady',
\ 'HiDead': 'SharpenUpDead'
\}

set statusline=%<%f%h%m%r%=%b\ \ %l,%c%V
let &statusline .= sharpenup#statusline#Build()
set statusline+=\ %P

let g:sharpenup_codeactions_autocmd = 'CursorHold,CursorMoved,BufEnter'

let g:OmniSharp_popup_mappings = {
    \ 'sigNext': '<C-n>',
    \ 'sigPrev': '<C-p>',
    \ 'pageDown': ['<C-f>', '<PageDown>'],
    \ 'pageUp': ['<C-b>', '<PageUp>']
\ }

augroup lightline_integration
  autocmd!
  autocmd User OmniSharpStarted,OmniSharpReady,OmniSharpStopped call lightline#update()
augroup END

" ----------------------------------------------------------------------
" Omnisharp commands
" -----------------------------------------------------------------------
augroup omnisharp_commands
    autocmd!

    " ----------------------------------------------------------------------
    " New settings START!
    " ----------------------------------------------------------------------

    " Show type information automatically when the cursor stops moving.
    " Note that the type is echoed to the Vim command line, and will overwrite
    " any other messages in this space including e.g. ALE linting messages.
    " autocmd CursorHold *.cs OmniSharpTypeLookup

    " ----------------------------------------------------------------------
    " Code Actions
    " ----------------------------------------------------------------------
    autocmd FileType cs nmap <silent> <buffer> gd <Plug>(omnisharp_go_to_definition)
    autocmd FileType cs nmap <silent> <buffer> <Leader>fu <Plug>(omnisharp_find_usages)
    autocmd FileType cs nmap <silent> <buffer> <Leader>fi <Plug>(omnisharp_find_implementations)
    autocmd FileType cs nmap <silent> <buffer> <Leader>pd <Plug>(omnisharp_documentation)
    autocmd FileType cs nmap <silent> <buffer> <Leader>td <Plug>(omnisharp_documentation)
    autocmd FileType cs nmap <silent> <buffer> <Leader>fs <Plug>(omnisharp_find_symbol)
    autocmd FileType cs nmap <silent> <buffer> <Leader>fx <Plug>(omnisharp_fix_usings)
    autocmd FileType cs nmap <silent> <buffer> <Leader>ra <Plug>(omnisharp_code_actions)
    autocmd FileType cs nmap <silent> <buffer> <Leader>rr <Plug>(omnisharp_code_action_repeat)
    autocmd FileType cs nmap <silent> <buffer> <Leader>gc <Plug>(omnisharp_global_code_check)
    autocmd FileType cs nmap <silent> <buffer> <Leader>cf <Plug>(omnisharp_code_format)

    autocmd FileType cs nmap <silent> <buffer> <Leader>osca <Plug>(omnisharp_code_actions)
    autocmd FileType cs xmap <silent> <buffer> <Leader>osca <Plug>(omnisharp_code_actions)

    " ----------------------------------------------------------------------
    " Rename
    " ----------------------------------------------------------------------
    autocmd FileType cs nmap <silent> <buffer> <Leader>nm <Plug>(omnisharp_rename)

    " ----------------------------------------------------------------------
    " Server Actions
    " ----------------------------------------------------------------------
    autocmd FileType cs nmap <silent> <buffer> <F5> <Plug>(omnisharp_restart_server)
    autocmd FileType cs nmap <silent> <buffer> <F6> <Plug>(omnisharp_start_server)
    autocmd FileType cs nmap <silent> <buffer> <F7> <Plug>(omnisharp_stop_server)

    " ----------------------------------------------------------------------
    " Method Actions
    " ----------------------------------------------------------------------
    autocmd FileType cs nmap <silent> <buffer> [[ <Plug>(ale_previous_wrap_error)
    autocmd FileType cs nmap <silent> <buffer> ]] <Plug>(ale_next_wrap_error)

    autocmd FileType cs nmap <silent> <buffer> .. <Plug>(ale_next_wrap_warning)
    autocmd FileType cs nmap <silent> <buffer> ,, <Plug>(ale_previous_wrap_warning)

    " ----------------------------------------------------------------------
    " C# Legacy Utils
    " ----------------------------------------------------------------------
    autocmd FileType cs nmap <silent> <buffer> <Leader>ad <Plug>(sharpenup_add_to_csproj)
    autocmd FileType cs nmap <silent> <buffer> <Leader>ln <Plug>(sharpenup_rename_in_csproj)

    " ----------------------------------------------------------------------
    " ALE Diagnostics
    " ----------------------------------------------------------------------
    autocmd FileType cs nnoremap <Leader>sd :ALEDetail<CR>

    " ----------------------------------------------------------------------
    " New settings END
    " ----------------------------------------------------------------------
augroup END
