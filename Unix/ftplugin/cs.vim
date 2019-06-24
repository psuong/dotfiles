" OmniSharp
let g:OmniSharp_server_stdio = 1        " Use the Stdio server
let g:Omnisharp_timeout=5               " Timeout in 5 seconds
set previewheight=5                     " Set the preview height to 5 units
set splitbelow                          " Put the preview on the bottom
set completeopt=longest,menuone,preview " Enable documentations and previews to show
let g:OmniSharp_typeLookupInPreview = 1 " Use a preview window instead of echoing it in the cmd line
let g:OmniSharp_selector_ui='fzf'       " Use fzf by default
let g:OmniSharp_server_stdio = 1        " Use the rosyln stdio server instead.
let g:OmniSharp_highlight_types = 1     " Self explanatory

" ALE
let g:ale_linters = { 'cs': ['OmniSharp'] }

augroup omnisharp_commands " Automatic omnisharp commands
    autocmd!

    autocmd CursorHold *.cs call OmniSharp#TypeLookupWithoutDocumentation()
    autocmd FileType cs nnoremap <buffer> gd :OmniSharpGotoDefinition<CR>
    autocmd FileType cs nnoremap <buffer> <Leader>fi :OmniSharpFindImplementations<CR>
    autocmd FileType cs nnoremap <buffer> <Leader>fs :OmniSharpFindSymbol<CR>
    autocmd FileType cs nnoremap <buffer> <Leader>fu :OmniSharpFindUsages<CR>
    autocmd FileType cs nnoremap <buffer> <Leader>fm :OmniSharpFindMembers<CR>
    autocmd FileType cs nnoremap <buffer> <Leader>fx :OmniSharpFixUsings<CR>
    autocmd FileType cs nnoremap <buffer> <Leader>tl :OmniSharpTypeLookup<CR>
    autocmd FileType cs nnoremap <buffer> <Leader>dc :OmniSharpDocumentation<CR>
    autocmd FileType cs nnoremap <buffer> <C-\> :OmniSharpSignatureHelp<CR>
    autocmd FileType cs inoremap <buffer> <C-\> <C-o>:OmniSharpSignatureHelp<CR>
    autocmd FileType cs nnoremap <buffer> <C-k> :OmniSharpNavigateUp<CR>
    autocmd FileType cs nnoremap <buffer> <C-j> :OmniSharpNavigateDown<CR>

    " Enabled with fzf
    autocmd FileType cs xnoremap <Leader><Space> :call OmniSharp#GetCodeActions('visual')<CR>
    autocmd FileType cs nnoremap <Leader>nm :OmniSharpRename<CR>
    autocmd FileType cs nnoremap <Leader>ra :OmniSharpGetCodeActions<CR>
    " Rename without dialog - with cursor on the symbol to rename: `:Rename newname`
    command! -nargs=1 Rename :call OmniSharp#RenameTo("<args>")
    autocmd FileType cs nnoremap <Leader>cf :OmniSharpCodeFormat<CR> 
    autocmd FileType cs nnoremap <Leader>ss :OmniSharpStartServer<CR>
    autocmd FileType cs nnoremap <Leader>sp :OmniSharpStopServer<CR>
    autocmd FileType cs nnoremap <Leader>th :OmniSharpHighlightTypes<CR>
augroup END