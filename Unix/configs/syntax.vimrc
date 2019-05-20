" UltiSnippets
let g:UltiSnipsExpandTrigger="<F1>"
let g:UltiSnipsJumpForwardTrigger="<c-x>"
let g:UltiSnipsJumpBackwardTrigger="<c-c>"

" Omnisharp Vim
let g:Omnisharp_timeout=10              " Timeout in 10 seconds
set completeopt=longest,menuone,preview " Enable documentations and previews to show
set previewheight=5                     " Set the height to 5 for docs
set splitbelow                          " Put the preview on the bottom
let g:OmniSharp_typeLookupInPreview = 1 " Use a preview window instead of echoing it in the cmd line
let g:OmniSharp_selector_ui='fzf'       " Use fzf by default
let g:OmniSharp_want_snippet = 1        " Get snippets

" ALE
let g:ale_linters = { 'cs' : ['OmniSharp'] }    " Use the CSharp linter

augroup omnisharp_commands " Automatic omnisharp commands
    autocmd!

    autocmd CursorHold *.cs call OmniSharp#TypeLookupWithoutDocumentation()
    autocmd FileType cs nnoremap <buffer> gd :OmniSharpGotoDefinition<CR>
    autocmd FileType cs nnoremap <buffer> <Leader>fi :OmniSharpFindImplementations<CR>
    autocmd FileType cs nnoremap <buffer> <Leader>fs :OmniSharpFindSymbol<CR>
    autocmd FileType cs nnoremap <buffer> <Leader>fu :OmniSharpFindUsages<CR>
    autocmd FileType cs nnoremap <buffer> <Leader>fm :OmniSharpFindMembers<CR>
    autocmd FileType cs nnoremap <buffer> <Leader>fx :OmniSharpFixUsings<CR>
    autocmd FileType cs nnoremap <buffer> <Leader>tt :OmniSharpTypeLookup<CR>
    autocmd FileType cs nnoremap <buffer> <Leader>dc :OmniSharpDocumentation<CR>
    autocmd FileType cs nnoremap <buffer> <C-\> :OmniSharpSignatureHelp<CR>
    autocmd FileType cs inoremap <buffer> <C-\> <C-o>:OmniSharpSignatureHelp<CR>
    autocmd FileType cs nnoremap <buffer> <C-k> :OmniSharpNavigateUp<CR>
    autocmd FileType cs nnoremap <buffer> <C-j> :OmniSharpNavigateDown<CR>
augroup END

" Enabled with CtrlP
nnoremap <Leader><Space> :OmniSharpGetCodeActions<CR>
xnoremap <Leader><Space> :call OmniSharp#GetCodeActions('visual')<CR>
nnoremap <Leader>nm :OmniSharpRename<CR>
nnoremap <Leader>ra :OmniSharpGetCodeActions<CR>
nnoremap <F2> :OmniSharpRename<CR>
" Rename without dialog - with cursor on the symbol to rename: `:Rename newname`
command! -nargs=1 Rename :call OmniSharp#RenameTo("<args>")
nnoremap <Leader>cf :OmniSharpCodeFormat<CR> 
nnoremap <Leader>ss :OmniSharpStartServer<CR>
nnoremap <Leader>sp :OmniSharpStopServer<CR>
nnoremap <Leader>th :OmniSharpHighlightTypes<CR>
