" ----------------------------------------------------------------------
" LSP Settings for Rust
" ----------------------------------------------------------------------
function! ShowDocumentation()
    if CocAction('hasProvider', 'hover')
        call CocActionAsync('doHover')
    endif
endfunction

augroup rust_commands
    autocmd!

    " Highlight the symbol and its references when holding the cursor.
    autocmd CursorHold * silent call CocActionAsync('highlight')

    command! -nargs=0 Format :call CocActionAsync('format')

    autocmd FileType rust nmap <silent> <Leader>gd <Plug>(coc-definition)
    autocmd FileType rust nmap <silent> <buffer> <Leader>pd :call ShowDocumentation()<CR>
    autocmd FileType rust nmap <silent> <buffer> <Leader>fu <Plug>(coc-references)
    autocmd FileType rust nmap <silent> <buffer> <Leader>nm <Plug>(coc-rename)
    autocmd FileType rust nmap <silent> <buffer> <Leader>ra <Plug>(coc-codeaction)
    autocmd FileType rust nmap <silent> <Leader>cf :Format<CR>
    autocmd FileType rust nmap <silent> <buffer> <Leader>gc :CocDiagnostics<CR>
    autocmd FileType rust nmap <silent> [[ <Plug>(coc-diagnostic-next)
    autocmd FileType rust nmap <silent> ]] <Plug>(coc-diagnostic-prev)
augroup END
