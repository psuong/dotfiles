" ----------------------------------------------------------------------
" NERDTree Settings
" ----------------------------------------------------------------------
" autocmd vimenter * NERDTree                                                             " Autostart NERDTree
" let g:NERDTreeDirArrowExpandable = '+'                                                  " Arrow to expand directories
" let g:NERDTreeDirArrowCollapsible = '-'                                                 " Arrow for expanded directories
" let NERDTreeShowHidden = 1                                                              " Show hidden files
" map <C-n> :NERDTreeToggle<CR>                                                           " Ctrl + N for expanding NERDTree
" map <C-f> :NERDTreeFind<CR>                                                             " Ctrl + F to find the file in NERDTree
" let NERDTreeIgnore = ['\.meta$', '\.swp$', '\.DS_Store']                                " Ignore meta files generated from Unity and vim swap files.
" 
" " Close NERDTree if it's the last one opened.
" autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
" 
" " NERDTress File highlighting
" function! NERDTreeHighlightFile(extension, fg, bg, guifg, guibg)
"  exec 'autocmd filetype nerdtree highlight ' . a:extension .' ctermbg='. a:bg .' ctermfg='. a:fg .' guibg='. a:guibg .' guifg='. a:guifg
"  exec 'autocmd filetype nerdtree syn match ' . a:extension .' #^\s\+.*'. a:extension .'$#'
" endfunction

" ----------------------------------------------------------------------
" NERDTree Color Settings
" ----------------------------------------------------------------------
" call NERDTreeHighlightFile('jade', 'green', 'none', 'green', '#151515')
" call NERDTreeHighlightFile('ini', 'yellow', 'none', 'yellow', '#151515')
" call NERDTreeHighlightFile('md', 'blue', 'none', '#3366FF', '#151515')
" call NERDTreeHighlightFile('yml', 'yellow', 'none', 'yellow', '#151515')
" call NERDTreeHighlightFile('config', 'yellow', 'none', 'yellow', '#151515')
" call NERDTreeHighlightFile('conf', 'yellow', 'none', 'yellow', '#151515')
" call NERDTreeHighlightFile('json', 'yellow', 'none', 'yellow', '#151515')
" call NERDTreeHighlightFile('html', 'yellow', 'none', 'yellow', '#151515')
" call NERDTreeHighlightFile('styl', 'cyan', 'none', 'cyan', '#151515')
" call NERDTreeHighlightFile('css', 'cyan', 'none', 'cyan', '#151515')
" call NERDTreeHighlightFile('coffee', 'Red', 'none', 'red', '#151515')
" call NERDTreeHighlightFile('js', 'Red', 'none', '#ffa500', '#151515')
" call NERDTreeHighlightFile('php', 'Magenta', 'none', '#ff00ff', '#151515')
" call NERDTreeHighlightFile('ds_store', 'Gray', 'none', '#686868', '#151515')
" call NERDTreeHighlightFile('gitconfig', 'Gray', 'none', '#686868', '#151515')
" call NERDTreeHighlightFile('gitignore', 'Gray', 'none', '#686868', '#151515')
" call NERDTreeHighlightFile('bashrc', 'Gray', 'none', '#686868', '#151515')
" call NERDTreeHighlightFile('bashprofile', 'Gray', 'none', '#686868', '#151515')

" ----------------------------------------------------------------------
" Git Helpers
" ----------------------------------------------------------------------
command! Gpush Git push
command! Gpull Git pull
command! Gfetch Git fetch

" ----------------------------------------------------------------------
" Fern Settings
" ----------------------------------------------------------------------
let g:fern#mark_symbol                       = '● '
let g:fern#renderer#default#collapsed_symbol = '+ '
let g:fern#renderer#default#expanded_symbol  = '- '
let g:fern#renderer#default#leading          = ' '
let g:fern#renderer#default#leaf_symbol      = ' '
let g:fern#renderer#default#root_symbol      = '~ '

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
  nmap <c-n> :Fern . -drawer<CR>
  nmap <c-b> :FernDo close<CR>

  " ----------------------------------------------------------------
  " Press o to open the file
  " ----------------------------------------------------------------
  nmap <buffer> o <Plug>(fern-action-open) 
endfunction

augroup fern-custom
  autocmd! *
  autocmd FileType fern call s:init_fern()
augroup END

autocmd vimenter * ++nested Fern . -drawer
