" NERDTree Settings
autocmd vimenter * NERDTree                              " Autostart NERDTree
let g:NERDTreeDirArrowExpandable = '+'                   " Arrow to expand directories
let g:NERDTreeDirArrowCollapsible = '-'                  " Arrow for expanded directories
let NERDTreeShowHidden=1                                 " Show hidden files
map <C-n> :NERDTreeToggle<CR>                            " Ctrl + N for expanding NERDTree
let NERDTreeIgnore = ['\.meta$', '\.swp$', '\.DS_Store'] " Ignore meta files generated from Unity and vim swap files.

" Close NERDTree if it's the last one opened.
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

" NERDTress File highlighting
function! NERDTreeHighlightFile(extension, fg, bg, guifg, guibg)
 exec 'autocmd filetype nerdtree highlight ' . a:extension .' ctermbg='. a:bg .' ctermfg='. a:fg .' guibg='. a:guibg .' guifg='. a:guifg
 exec 'autocmd filetype nerdtree syn match ' . a:extension .' #^\s\+.*'. a:extension .'$#'
endfunction
