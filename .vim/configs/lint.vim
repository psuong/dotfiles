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

" ----------------------------------------------------------------------
" Autocompletion
" ----------------------------------------------------------------------
let g:float_preview#docked = 0
set completeopt=menuone,noinsert,noselect

" ----------------------------------------------------------------------
" Tabbing support
" ----------------------------------------------------------------------

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
