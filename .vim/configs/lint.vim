" ALE
let g:ale_linters = {
\ 'cs': ['OmniSharp'],
\ 'rust': ['rls']
\}

let g:ale_sign_column_always = 1
let g:ale_sign_error = 'x'
let g:ale_sign_warning = '?'

" OmniSharp configs that need to load before ftplugin
let g:OmniSharp_server_stdio = 1                    " Use the Stdio server
let g:Omnisharp_timeout=5                           " Timeout in 5 seconds
set previewheight=5                                 " Set the preview height to 5 units, meant for documentation lookup
set splitbelow                                      " Put the preview on the bottom

let g:OmniSharp_typeLookupInPreview = 1             " Use a preview window instead of echoing it in the cmd line
let g:OmniSharp_selector_ui='fzf'                   " Use fzf by default
let g:OmniSharp_highlight_types = 2                 " 2: for buffer enter/leave, 3 for any kind of typing
let g:OmniSharp_want_snippet = 1                    " Uses Ultisnips to fill out the function params if enabled

" Nvim documenation preview
set completeopt=longest,menuone,preview             " Documenation shows in a preview window

" WSL Stuff (Enabled)
let g:OmniSharp_translate_cygwin_wsl = 1
let g:OmniSharp_server_path = '/mnt/c/Users/Blank/sources/omnisharp-win-x64/OmniSharp.exe'

if has('macunix')
    let g:OmniSharp_server_use_mono = 1
    let g:Omnisharp_server_path = '/Users/psuong/sources/omnisharp-osx/run'
endif

" C# SharpenUp
let g:sharpenup_codeactions_autocmd = 'CursorHold,CursorMoved,BufEnter'

" Popups

let g:OmniSharp = {
\ 'popup': {
\   'mappings': {
\     'sigNext': '<C-j>',
\     'sigPrev': '<C-k>',
\     'lineDown': ['<C-e>', 'j'],
\     'lineUp': ['<C-y>', 'k']
\   }
\ }
\}

" OmniSharp pop up support Nvim styling
let g:OmniSharp.popup.options = {
\ 'winblend': 30,
\ 'winhl': 'Normal:Normal'
\}

" Contextual code actions (uses fzf, CtrlP or unite.vim when available)
nnoremap <Leader><Space> :OmniSharpGetCodeActions<CR>
" Run code actions with text selected in visual mode to extract method
xnoremap <Leader><Space> :call OmniSharp#GetCodeActions('visual')<CR>

" Rename with dialog
nnoremap <Leader>nm :OmniSharpRename<CR>
nnoremap <F2> :OmniSharpRename<CR>
" Rename without dialog - with cursor on the symbol to rename: `:Rename newname`
command! -nargs=1 Rename :call OmniSharp#RenameTo("<args>")

nnoremap <Leader>cf :OmniSharpCodeFormat<CR>

" Start the omnisharp server for the current solution
nnoremap <Leader>ss :OmniSharpStartServer<CR>
nnoremap <Leader>sp :OmniSharpStopServer<CR>

" Rust 
autocmd User asyncomplete_setup call asyncomplete#register_source(
    \ asyncomplete#sources#racer#get_source_options())

" Vim Blamer
let g:blamer_enabled = 1
