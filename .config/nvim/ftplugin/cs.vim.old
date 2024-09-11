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
\   'winblend': 0,
\   'winhl': 'Normal:Normal,FloatBorder:Special',
\   'border': 'single'
\}

" ----------------------------------------------------------------------
" OmniSharp Server Settings
" -----------------------------------------------------------------------
let g:OmniSharp_server_stdio = 1
let g:Omnisharp_timeout = 5
let g:OmniSharp_diagnostic_showid = 1

" Show type information automatically when the cursor stops moving.
" Note that the type is echoed to the Vim command line, and will overwrite
" any other messages in this space including e.g. ALE linting messages.
" autocmd CursorHold *.cs OmniSharpTypeLookup
" autocmd FileType cs nmap <silent> <buffer> <Leader>tt :echo "Test Mapping"<CR>

" ----------------------------------------------------------------------
" Code Actions
" ----------------------------------------------------------------------
nmap <silent> <buffer> gd <Plug>(omnisharp_go_to_definition)
nmap <silent> <buffer> <Leader>fu <Plug>(omnisharp_find_usages)
nmap <silent> <buffer> <Leader>fi <Plug>(omnisharp_find_implementations)
nmap <silent> <buffer> <Leader>pd <Plug>(omnisharp_documentation)
nmap <silent> <buffer> <Leader>td <Plug>(omnisharp_documentation)
nmap <silent> <buffer> <Leader>fs <Plug>(omnisharp_find_symbol)
nmap <silent> <buffer> <Leader>fx <Plug>(omnisharp_fix_usings)
nmap <silent> <buffer> <Leader>ra <Plug>(omnisharp_code_actions)
nmap <silent> <buffer> <Leader>rr <Plug>(omnisharp_code_action_repeat)
nmap <silent> <buffer> <Leader>gc <Plug>(omnisharp_global_code_check)
nmap <silent> <buffer> <Leader>cf <Plug>(omnisharp_code_format)

nmap <silent> <buffer> <Leader>osca <Plug>(omnisharp_code_actions)
xmap <silent> <buffer> <Leader>osca <Plug>(omnisharp_code_actions)

nmap <silent> <buffer> <C-s> <Plug>(omnisharp_signature_help)
imap <silent> <buffer> <C-s> <Plug>(omnisharp_signature_help)

" ----------------------------------------------------------------------
" Rename
" ----------------------------------------------------------------------
nmap <silent> <buffer> <Leader>nm <Plug>(omnisharp_rename)

" ----------------------------------------------------------------------
" Server Actions
" ----------------------------------------------------------------------
nmap <silent> <buffer> <F5> <Plug>(omnisharp_restart_server)
nmap <silent> <buffer> <F6> <Plug>(omnisharp_start_server)
nmap <silent> <buffer> <F7> <Plug>(omnisharp_stop_server)

" ----------------------------------------------------------------------
" Method Actions
" ----------------------------------------------------------------------
nmap <silent> <buffer> [[ <Plug>(ale_previous_wrap_error)
nmap <silent> <buffer> ]] <Plug>(ale_next_wrap_error)

nmap <silent> <buffer> .. <Plug>(ale_next_wrap_warning)
nmap <silent> <buffer> ,, <Plug>(ale_previous_wrap_warning)

" ----------------------------------------------------------------------
" C# Legacy Utils
" ----------------------------------------------------------------------
nmap <silent> <buffer> <Leader>ad <Plug>(sharpenup_add_to_csproj)
nmap <silent> <buffer> <Leader>ln <Plug>(sharpenup_rename_in_csproj)

" ----------------------------------------------------------------------
" ALE Diagnostics
" ----------------------------------------------------------------------
nnoremap <Leader>sd :ALEDetail<CR>