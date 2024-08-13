" ----------------------------------------------------------------------
" ALE Settings
" ----------------------------------------------------------------------
let g:ale_linters_explicit = 1
let g:ale_sign_error = '•'
let g:ale_sign_warning = '•'
let g:ale_sign_info = '·'
let g:ale_sign_style_error = '·'
let g:ale_sign_style_warning = '·'
let g:ale_sign_column_always = 1
let g:ale_virtualtext_cursor = 0
let g:ale_virtualtext_delay = 5
let g:ale_set_highlights = 0
let g:ale_use_neovim_diagnostics_api = 1
let g:ale_floating_preview = 1
let g:ale_hover_to_floating_preview = 1
let g:ale_popup_menu_enabled = 1
let g:ale_set_loclist = 1
let g:ale_set_quickfix = 0
let g:ale_linters = {
    \ 'cs': ['OmniSharp'],
\}
let g:OmniSharp_diagnostic_showid = 1

augroup omnisharp_hotkeys
    autocmd!
    " Show type information automatically when the cursor stops moving.
    " Note that the type is echoed to the Vim command line, and will overwrite
    " any other messages in this space including e.g. ALE linting messages.
    " autocmd CursorHold *.cs OmniSharpTypeLookup
    autocmd FileType cs nmap <silent> <buffer> <Leader>tt :echo "Test Mapping"<CR>

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
augroup END
