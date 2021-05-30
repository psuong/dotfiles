" ----------------------------------------------------------------------
" Vim Easy Align
" ----------------------------------------------------------------------
" Start interactive EasyAlign in visual mode (e.g. vipga)
xmap ga <Plug>(EasyAlign)

" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)

" ----------------------------------------------------------------------
" Git Helpers
" ----------------------------------------------------------------------
command! -bang -bar -nargs=* Gpush execute 'Dispatch<bang> -dir=' .
    \ fnameescape(FugitiveGitDir()) 'git push' <q-args>
command! -bang -bar -nargs=* Gfetch execute 'Dispatch<bang> -dir=' .
    \ fnameescape(FugitiveGitDir()) 'git fetch' <q-args>
