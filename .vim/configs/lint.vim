" ----------------------------------------------------------------------
" Global ALE
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
    \ 'rust': ['vim-lsp', 'analyzer']
\}
let g:OmniSharp_diagnostic_showid = 1
let g:ale_floating_window_border = ['│', '─', '╭', '╮', '╯', '╰', '│', '─']

"" ----------------------------------------------------------------------
" Global vim-lsp Settings
" ----------------------------------------------------------------------
let g:lsp_settings = {
\   'omnisharp-lsp': {
\       'disabled': 1
\   }
\ }

let g:lsp_inlay_hints_enabled = 1
let g:lsp_inlay_hints_delay = 0
let g:lsp_inlay_hints_mode = {
\  'normal': ['!curline'],
\  'insert': ['!curline']
\}

" ---------------------------------------------------------------
" Because I'm using vim-lsp-ale, this section
" represents the value when g:lsp_ale_auto_config_vim_lsp is true
" ---------------------------------------------------------------
" let g:lsp_diagnostics_enabled = 1
" let g:lsp_diagnostics_echo_cursor = 0
" let g:lsp_diagnostics_float_cursor = 0
" let g:lsp_diagnostics_highlights_enabled = 0
" let g:lsp_diagnostics_signs_enabled = 0
" let g:lsp_diagnostics_virtual_text_enabled = 0

" vim-lsp virtual text settings
let g:lsp_diagnostics_virtual_text_delay = 0

" vim-lsp highlighting settings
let g:lsp_document_highlight_enabled = 0

" vim-lsp document signs
let g:lsp_document_code_action_signs_delay = 0
let g:lsp_document_code_action_signs_hint = { 'text': '💡' }
let g:lsp_diagnostics_signs_error = { 'text': 'E' }
let g:lsp_diagnostics_signs_warning = { 'text': 'W' }
let g:lsp_diagnostics_signs_hint = { 'text': '💡' }

highlight link LspErrorText GruvboxRedUnderline
highlight link LspWarningText GruvboxYellowUnderline
highlight link LspInformation GruvboxGray
highlight link LspHint GruvboxGray

" ----------------------------------------------------------------------
" Autocompletion
" ----------------------------------------------------------------------
let g:float_preview#docked = 0
let g:asyncomplete_auto_completeopt = 0
set completeopt=menuone,noinsert,noselect

" ----------------------------------------------------------------------
" Tabbing support
" ----------------------------------------------------------------------
inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
inoremap <expr> <cr>    pumvisible() ? "\<C-y>" : "\<cr>"
autocmd! CompleteDone * if pumvisible() == 0 | pclose | endif
imap <c-space> <Plug>(asyncomplete_force_refresh)

" ----------------------------------------------------------------------
" Snippet support
" ----------------------------------------------------------------------
if has('python3')
    let g:UltiSnipsExpandTrigger="<c-o>"
    let g:UltiSnipsJumpForwardTrigger="<c-j>"
    let g:UltiSnipsJumpBackwardTrigger="<c-k>"
endif

" ----------------------------------------------------------------------
" Treesitter syntax highlighting
" ----------------------------------------------------------------------
lua <<EOF
    require 'nvim-treesitter.install'.compilers = { "clang", "gcc" }
    require'nvim-treesitter.configs'.setup {
        -- A list of parser names, or "all"
        ensure_installed = { "c", "c_sharp", "rust", "hlsl", "glsl", "yaml", "toml", "xml" },
  
        -- Install parsers synchronously (only applied to `ensure_installed`)
        sync_install = false,
  
        highlight = {
          -- `false` will disable the whole extension
          enable = true,
          -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
          -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
          -- Using this option may slow down your editor, and you may see some duplicate highlights.
          -- Instead of true it can also be a list of languages
          additional_vim_regex_highlighting = false,
        },
    }
EOF

" ----------------------------------------------------------------------
" Tagbar
" ----------------------------------------------------------------------
nmap <S-o> :TagbarToggle<CR>
let g:tagbar_foldlevel = 3
let g:tagbar_iconchars = ['▸', '▾']

let g:tagbar_scopestrs = {
\   'class': "\uf0e8",
\   'const': "\uf8ff",
\   'constant': "\uf8ff",
\   'enum': "\uf702",
\   'field': "\uf30b",
\   'func': "\uf794",
\   'method': "\u21d2",
\   'function': "\u21d2",
\   'getter': "\ufab6",
\   'implementation': "\uf776",
\   'interface': "\uf7fe",
\   'map': "\ufb44",
\   'member': "\uf02b",
\   'setter': "\uf7a9",
\   'variable': "\uf71b",
\   'namespace': "\u2026",
\   'struct': "\u03C8",
\ }
let g:tagbar_show_tag_linenumbers = 1
let g:tagbar_visibility_symbols = {
\   'public'    : '+',
\   'protected' : '*',
\   'private'   : '-'
\ }

augroup BufferEnter
    autocmd!
    autocmd BufEnter * call CheckBufferName()
augroup END

function! CheckBufferName()
    let buffer_name = bufname('%')
    if stridx(buffer_name, 'Tagbar') != -1
        set syntax=ON
    endif
endfunction

" ----------------------------------------------------------------------
" Filetype extensions
" ----------------------------------------------------------------------
au! BufRead,BufNewFile *.shader setfiletype glsl

" ----------------------------------------------------------------------
" Vim Doge (DocGen)
" ----------------------------------------------------------------------
let g:doge_enable_mappings = 0
" Generate comments
nmap <silent> <Leader>d <Plug>(doge-generate)

let g:doge_mapping='<Leader>d'
let g:doge_mapping_comment_jump_forward='<C-j>'
let g:doge_mapping_comment_jump_backward='<C-k>'

" Interactive mode comment todo-jumping.
nmap <silent> <C-j> <Plug>(doge-comment-jump-forward)
nmap <silent> <C-k> <Plug>(doge-comment-jump-backward)
imap <silent> <C-j> <Plug>(doge-comment-jump-forward)
imap <silent> <C-k> <Plug>(doge-comment-jump-backward)
smap <silent> <C-j> <Plug>(doge-comment-jump-forward)
smap <silent> <C-k> <Plug>(doge-comment-jump-backward)
