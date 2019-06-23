" Rebind ultisnips to something never used. We use CleverTab :)
let g:UltiSnipsExpandTrigger="<f12>"
let g:UltiSnipsJumpForwardTrigger="<f12>"
let g:UltiSnipsJumpBackwardTrigger="<f12>"

snoremap <Tab> <Esc>:call UltiSnips#ExpandSnippetOrJump()<cr>
xnoremap <Tab> :call UltiSnips#SaveLastVisualSelection()<cr>gvs
snoremap <C-k> <Esc>:call UltiSnips#JumpBackwards()<cr>
inoremap <C-k> <Esc>:call UltiSnips#JumpBackwards()<cr>
snoremap <C-j> <Esc>:call UltiSnips#JumpForwards()<cr>
inoremap <C-j> <Esc>:call UltiSnips#JumpForwards()<cr>

" Deoplete

let g:deoplete#enable_at_startup = 1
" Disable the candidates in Comment/String syntaxes.
call deoplete#custom#source('_', 'disabled_syntaxes', ['Comment', 'String'])
aug ClosePreview
    au!
    autocmd InsertLeave,CompleteDone * if pumvisible() == 0 | pclose | endif
aug END
call deoplete#custom#var('omni', 'input_patterns', {
    \ 'ruby': ['[^. *\t]\.\w*', '[a-zA-Z_]\w*::'],
    \ 'java': '[^. *\t]\.\w*',
    \ 'cs': '\w+|[^. *\t]\.\w*',
    \ 'php': '\w+|[^. \t]->\w*|\w+::\w*',
    \})
call deoplete#custom#option('min_pattern_length', 1)
call deoplete#custom#option('sources', {
\ '_': ['ultisnips'],
\ 'cs': ['omnisharp', 'ultisnips'],
\ 'rust': ['racer', 'ultisnips'],
\ 'sh': ['LanguageClient', 'ultisnips'],
\ 'python': ['jedi', 'ultisnips'],
\ 'javascript': ['LanguageClient', 'ultisnips'],
\})

command! DeopleteDisable :call deoplete#disable()
command! DeopleteEnable :call deoplete#enable()

" Use % to jump between region/endregion
let b:match_words = '\s*#\s*region.*$:\s*#\s*endregion'
let g:OmniSharp_server_stdio = 1

nnoremap <buffer> K :call OmniSharp#TypeLookupWithoutDocumentation()<CR>

" The following commands are contextual, based on the cursor position.
nnoremap <buffer> gd m':OmniSharpGotoDefinition<CR>
nnoremap <buffer> gD m':$tab split<CR>:OmniSharpGotoDefinition<CR>
nnoremap <buffer> gi :OmniSharpFindImplementations<CR>
nnoremap <buffer> gs :OmniSharpFindSymbol 
nnoremap <buffer> gr :OmniSharpFindUsages<CR>
nnoremap <buffer> gm :OmniSharpFindMembers<CR>

nnoremap <buffer> <leader>o :OmniSharpFixUsings<CR>

nnoremap <buffer> <Leader>k :OmniSharpTypeLookup<CR>
nnoremap <buffer> <Leader>dc :OmniSharpDocumentation<CR>

" Navigate up and down by method/property/field
nnoremap <buffer> [[ :OmniSharpNavigateUp<CR>zz
nnoremap <buffer> ]] :OmniSharpNavigateDown<CR>zz

nnoremap <buffer> <Leader><Space> :OmniSharpGetCodeActions<CR>
xnoremap <buffer> <Leader><Space> :call OmniSharp#GetCodeActions('visual')<CR>

nnoremap <buffer> <Leader>r :OmniSharpRename<CR>
" Rename without dialog - with cursor on the symbol to rename: `:Rename newname`
command! -buffer -nargs=1 Rename :call OmniSharp#RenameTo("<args>")

nnoremap <buffer> <Leader>f :OmniSharpCodeFormat<CR>

nnoremap <buffer> <F5> :OmniSharpRestartAllServers<CR>

augroup csfmt
  autocmd! * <buffer>
  autocmd BufWriteCmd <buffer> call smartformat#Format('cs', 'call OmniSharp#CodeFormat({->execute("noau w")})')
augroup END
augroup csopts
  autocmd! * <buffer>
  autocmd BufWinEnter <buffer> setlocal tw=100 foldmethod=syntax
augroup END