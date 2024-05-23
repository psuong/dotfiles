" ----------------------------------------------------------------------
" Fern Settings
" ----------------------------------------------------------------------
let hide_dirs  = '^\%(\.git\)$'  " here you write the dir names 
let hide_files = '\%(\.meta\)\+'    " here you write the file names
let g:fern#default_exclude = hide_dirs . '\|' . hide_files  " here you exclude them

let g:fern#renderer = "nvim-web-devicons"
let g:fern#hide_cursor = 1

augroup my-glyph-palette
  autocmd! *
  autocmd FileType fern call glyph_palette#apply()
  autocmd FileType nerdtree,startify call glyph_palette#apply()
augroup END

function! s:fern_settings() abort
  nmap <silent> <buffer> p     <Plug>(fern-action-preview:toggle)
  nmap <silent> <buffer> <C-p> <Plug>(fern-action-preview:auto:toggle)
  nmap <silent> <buffer> <C-d> <Plug>(fern-action-preview:scroll:down:half)
  nmap <silent> <buffer> <C-u> <Plug>(fern-action-preview:scroll:up:half)
endfunction

augroup fern-settings
  autocmd!
  autocmd FileType fern call s:fern_settings()
augroup END

function! s:init_fern() abort
  " ----------------------------------------------------------------
  " Perform expand or collapse
  " ----------------------------------------------------------------
  nmap <buffer><expr>
    \ <Plug>(fern-my-expand-or-collapse)
    \ fern#smart#leaf(
    \   "\<Plug>(fern-action-collapse)",
    \   "\<Plug>(fern-action-expand)",
    \   "\<Plug>(fern-action-collapse)",
    \ )

  nmap <buffer><nowait> <enter> <Plug>(fern-my-expand-or-collapse)
  " ----------------------------------------------------------------
  " Bind opening and closing the fern buffer
  " ----------------------------------------------------------------
  nmap <c-n> :Fern . -drawer -toggle -width=35<CR>
  nmap <c-b> :FernDo close<CR>

  " ----------------------------------------------------------------
  " Press o to open the file
  " ----------------------------------------------------------------
  nmap <buffer> o <Plug>(fern-action-open) 
endfunction

augroup fern-custom
  autocmd! *
  autocmd FileType fern call s:init_fern()
  autocmd FileType fern set nonumber
augroup END

autocmd vimenter * ++nested Fern . -drawer -toggle -width=35

" ----------------------------------------------------------------------
" Vim Clap
" ----------------------------------------------------------------------
let g:clap_enable_icon=1
let g:clap_plugin_experimental = v:true
nmap <c-p> :Clap files<CR>
let g:clap_layout = { 
\   'relative': 'editor'
\ }

autocmd FileType clap_input let g:asyncomplete_auto_popup = 0

augroup VimClapEnterExitGroup
  autocmd!
  autocmd User ClapOnEnter   call DisableAsyncomplete()
  autocmd User ClapOnExit    call EnableAsyncomplete()
augroup END

:function DisableAsyncomplete()
:   let g:asyncomplete_auto_popup = 0
:endfunction

:function EnableAsyncomplete()
:   let g:asyncomplete_auto_popup = 1
:endfunction
