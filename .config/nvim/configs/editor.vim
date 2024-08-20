" ----------------------------------------------------------------------
" Buffer Settings
" ----------------------------------------------------------------------
set autoread                        " Automatically reload the buffer when changed outside of Vim
set hidden                          " Stops the buffer from closing
set noswapfile                      " Don't generate swap files
syntax manual                       " Make syntax highlighting manual

" ----------------------------------------------------------------------
" Plugin availability
" ----------------------------------------------------------------------
filetype plugin indent on

" ----------------------------------------------------------------------
" Font Encoding
" ----------------------------------------------------------------------
set encoding=UTF-8
scriptencoding utf-8

" ----------------------------------------------------------------------
" Visual Studio Like Settings
" ----------------------------------------------------------------------
set expandtab                       " Tabs are spaces
set tabstop=4                       " Number of visual spaces per tabs
set softtabstop=4                   " Number of spaces in tabs when editing
set shiftwidth=4                    " Number of spaces text is indented
set smartindent                     " Automate indenting on a new line
set signcolumn=yes                  " Always enable the sign column
set title
set linespace=1

" ----------------------------------------------------------------------
" Basic Vim Settings
" --------------------------------------------------------------------------
set number                          " Show number lines
set colorcolumn=100                 " Show the max number of lines
set cursorline                      " Highlight the current line number
set showcmd                         " Show the vim commands
set wrap                            " Wrap horizontally long lines
set encoding=utf-8                  " Default to UTF-8
set noshowmode                      " Linelight shows this already
highlight ColorColumn ctermbg=0 guibg=lightgrey

" Use truecolor in the terminal, when it is supported
if has('termguicolors')
    set termguicolors
endif

" --------------------------------------------------------
" Add Tab Bars
" --------------------------------------------------------
" Move to previous/next
nnoremap <silent>    <A-,> <Cmd>BufferPrevious<CR>
nnoremap <silent>    <A-.> <Cmd>BufferNext<CR>

" Re-order to previous/next
nnoremap <silent>    <A-<> <Cmd>BufferMovePrevious<CR>
nnoremap <silent>    <A->> <Cmd>BufferMoveNext<CR>

" Goto buffer in position...
nnoremap <silent>    <A-1> <Cmd>BufferGoto 1<CR>
nnoremap <silent>    <A-2> <Cmd>BufferGoto 2<CR>
nnoremap <silent>    <A-3> <Cmd>BufferGoto 3<CR>
nnoremap <silent>    <A-4> <Cmd>BufferGoto 4<CR>
nnoremap <silent>    <A-5> <Cmd>BufferGoto 5<CR>
nnoremap <silent>    <A-6> <Cmd>BufferGoto 6<CR>
nnoremap <silent>    <A-7> <Cmd>BufferGoto 7<CR>
nnoremap <silent>    <A-8> <Cmd>BufferGoto 8<CR>
nnoremap <silent>    <A-9> <Cmd>BufferGoto 9<CR>
nnoremap <silent>    <A-0> <Cmd>BufferLast<CR>

" Pin/unpin buffer
nnoremap <silent>    <A-p> <Cmd>BufferPin<CR>

" Close buffer
nnoremap <silent>    <A-c> <Cmd>BufferClose<CR>
" Restore buffer
nnoremap <silent>    <A-s-c> <Cmd>BufferRestore<CR>

" Wipeout buffer
"                          :BufferWipeout
" Close commands
"                          :BufferCloseAllButCurrent
"                          :BufferCloseAllButVisible
"                          :BufferCloseAllButPinned
"                          :BufferCloseAllButCurrentOrPinned
"                          :BufferCloseBuffersLeft
"                          :BufferCloseBuffersRight

" Magic buffer-picking mode
nnoremap <silent> <C-p>    <Cmd>BufferPick<CR>
nnoremap <silent> <C-p>    <Cmd>BufferPickDelete<CR>

" Sort automatically by...
nnoremap <silent> <Space>bb <Cmd>BufferOrderByBufferNumber<CR>
nnoremap <silent> <Space>bd <Cmd>BufferOrderByDirectory<CR>
nnoremap <silent> <Space>bl <Cmd>BufferOrderByLanguage<CR>
nnoremap <silent> <Space>bw <Cmd>BufferOrderByWindowNumber<CR>

" Other:
" :BarbarEnable - enables barbar (enabled by default)

" ----------------------------------------------------------------------
" Font Settings
" ----------------------------------------------------------------------
set guifont=UbuntuMono\ Nerd\ Font\ Propo:h12

if exists('g:neovide')
    let g:neovide_cursor_animation_length = 0
    let g:neovide_cursor_vfx_mode = ""
    let g:neovide_floating_shadow = v:false
    let g:neovide_scroll_animation_length = 0
endif

" ----------------------------------------------------------------------
" Cursor settings
" ----------------------------------------------------------------------
nnoremap j gj
nnoremap k gk

" ----------------------------------------------------------------------
" Remap the leader key
" ----------------------------------------------------------------------
let mapleader = ","

" ----------------------------------------------------------------------
" Set splitting to be vertical by default
" ----------------------------------------------------------------------
set diffopt+=vertical

" ----------------------------------------------------------------------
" Get a decent set up without the $ sign at eol and to allow backspace support
" ----------------------------------------------------------------------
set nolist
set backspace=indent,eol,start

" --------------------------
" Lightline + Status Line
" --------------------------
set laststatus=3

let g:sharpenup_statusline_opts = {
\   'TextLoading': ' O#: %s ... (%p / %P) ',
\   'TextReady': ' O#: %s ✓ ',
\   'TextDead': ' O#: ✖ ',
\   'Highlight': 1,
\   'HiLoading': 'SharpenUpLoading',
\   'HiReady': 'SharpenUpReady',
\   'HiDead': 'SharpenUpDead'
\}

let g:lightline = {
\   'active': {
\       'right': [['filetype'], ['sharpenup']],
\       'left': [['mode'], ['linter_checking', 'linter_errors', 'linter_warnings', 'linter_infos', 'linter_ok']]
\   },
\   'inactive': {
\       'right': [['sharpenup']]
\   },
\   'component': {
\       'sharpenup': sharpenup#statusline#Build()
\   },
\   'component_expand': {
\       'linter_checking': 'lightline#ale#checking',
\       'linter_infos': 'lightline#ale#infos',
\       'linter_warnings': 'lightline#ale#warnings',
\       'linter_errors': 'lightline#ale#errors',
\       'linter_ok': 'lightline#ale#ok',
\   },
\   'component_type':  {
\       'linter_checking': 'right',
\       'linter_infos': 'right',
\       'linter_warnings': 'warning',
\       'linter_errors': 'error',
\       'linter_ok': 'right',
\   }
\}

augroup lightline_integration
    autocmd!
    autocmd User OmniSharpStarted,OmniSharpReady,OmniSharpStopped call lightline#update()
augroup END

lua <<EOF
    ----------------------
    -- Smooth scrolling --
    ----------------------
    require('neoscroll').setup()

    ------------
    -- Glyphs --
    ------------
    require'nvim-web-devicons'.get_icons()

    -----------
    -- Theme --
    -----------
    vim.o.background = 'dark'
    vim.cmd([[colorscheme gruvbox]])
    
    -- Default options:
    require("gruvbox").setup({
        terminal_colors = true, -- add neovim terminal colors
        undercurl = true,
        underline = true,
        bold = false,
        italic = {
            strings = false,
            emphasis = true,
            comments = false,
            operators = false,
            folds = true,
        },
        strikethrough = true,
        invert_selection = false,
        invert_signs = false,
        invert_tabline = false,
        invert_intend_guides = false,
        inverse = true, -- invert background for search, diffs, statuslines and errors
        contrast = "", -- can be "hard", "soft" or empty string
        palette_overrides = {},
        overrides = {},
        dim_inactive = false,
        transparent_mode = false,
    })
    vim.cmd("colorscheme gruvbox")
    
    local highlight = {
        "RainbowRed",
        "RainbowYellow",
        "RainbowBlue",
        "RainbowOrange",
        "RainbowGreen",
        "RainbowViolet",
        "RainbowCyan",
    }
    
    local hooks = require "ibl.hooks"
    -- create the highlight groups in the highlight setup hook, so they are reset
    -- every time the colorscheme changes
    hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
        vim.api.nvim_set_hl(0, "RainbowRed", { fg = "#E06C75" })
        vim.api.nvim_set_hl(0, "RainbowYellow", { fg = "#E5C07B" })
        vim.api.nvim_set_hl(0, "RainbowBlue", { fg = "#61AFEF" })
        vim.api.nvim_set_hl(0, "RainbowOrange", { fg = "#D19A66" })
        vim.api.nvim_set_hl(0, "RainbowGreen", { fg = "#98C379" })
        vim.api.nvim_set_hl(0, "RainbowViolet", { fg = "#C678DD" })
        vim.api.nvim_set_hl(0, "RainbowCyan", { fg = "#56B6C2" })
    end)
    
    -------------------
    -- Indent guides --
    -------------------
    require("ibl").setup { indent = { 
        highlight = highlight,
        char = "│"
    } }

    ------------------------------------
    -- Treesitter/Syntax Highlighting --
    ------------------------------------
    require('nvim-treesitter.install').compilers = { "clang", "gcc" }
    require('nvim-treesitter.configs').setup {
        -- A list of parser names, or "all"
        ensure_installed = { "c", "c_sharp", "rust", "hlsl", "glsl", "vimdoc", "powershell", "yaml" },

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
    vim.keymap.set("n", "[c", function()
        require("treesitter-context").go_to_context()
    end, { silent = true })

    ------------------
    --Ex Command UI --
    ------------------
    vim.api.nvim_set_keymap('n', '<CR>', '<cmd>FineCmdline<CR>', {noremap = true})
    local fineline = require('fine-cmdline')
    local fn = fineline.fn
      
    fineline.setup({
        cmdline = {
            -- Prompt can influence the completion engine.
            -- Change it to something that works for you
            prompt = ': ',
            -- Let the user handle the keybindings
            enable_keymaps = true,
            smart_history = true,
        },
        popup = {
            buf_options = {
                -- Setup a special file type if you need to
                filetype = 'FineCmdlinePrompt'
            },
            position = {
                row = '10%',
                col = '50%',
            },
            size = {
                width = '60%',
            },
            border = {
                style = 'rounded',
            },
            win_options = {
                winhighlight = 'Normal:Normal,FloatBorder:FloatBorder',
            },
        },
        -- Use the default keymaps provided by the plugin
    })
EOF

" ----------------------------------------------------------------------
" Terminal settings
" ----------------------------------------------------------------------
:tnoremap <A-w> <C-\><C-n>

" ----------------------------------------------------------------------
" Tagbar / Table of Contents
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
" Vim Doge (Documentation Stubber)
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

" ----------------------------------------------------------------------
" Autocompletion
" ----------------------------------------------------------------------
set completeopt=menuone,noinsert,noselect

" -------------------------
" Unset ultisnips from tab
" -------------------------
if has('python3')
    let g:UltiSnipsExpandTrigger="<c-q>"
    let g:UltiSnipsJumpForwardTrigger="<c-j>"
    let g:UltiSnipsJumpBackwardTrigger="<c-k>"
endif

" Expand
imap <expr> <C-w>   vsnip#expandable()  ? '<Plug>(vsnip-expand)'         : '<C-j>'
smap <expr> <C-w>   vsnip#expandable()  ? '<Plug>(vsnip-expand)'         : '<C-j>'

" Expand or jump
imap <expr> <C-h>   vsnip#available(1)  ? '<Plug>(vsnip-expand-or-jump)' : '<C-l>'
smap <expr> <C-h>   vsnip#available(1)  ? '<Plug>(vsnip-expand-or-jump)' : '<C-l>'

" Jump forward or backward
imap <expr> <C-j>   vsnip#jumpable(1)   ? '<Plug>(vsnip-jump-next)'      : '<Tab>'
smap <expr> <C-j>   vsnip#jumpable(1)   ? '<Plug>(vsnip-jump-next)'      : '<Tab>'
imap <expr> <C-k>   vsnip#jumpable(-1)  ? '<Plug>(vsnip-jump-prev)'      : '<S-Tab>'
smap <expr> <C-k>   vsnip#jumpable(-1)  ? '<Plug>(vsnip-jump-prev)'      : '<S-Tab>'

" Select or cut text to use as $TM_SELECTED_TEXT in the next snippet.
" See https://github.com/hrsh7th/vim-vsnip/pull/50
nmap        s   <Plug>(vsnip-select-text)
xmap        s   <Plug>(vsnip-select-text)
nmap        S   <Plug>(vsnip-cut-text)
xmap        S   <Plug>(vsnip-cut-text)

call ddc#custom#patch_global({
    \ 'ui': 'native',
    \ 'sources': [ 'lsp', 'omnisharp-vim', 'ultisnips', 'vsnip' ],
    \ 'sourceOptions': {
    \   '_': {
    \       'matchers': ['matcher_fuzzy'],
    \       'sorters' : ['sorter_fuzzy'],
    \       'converters' : ['converter_fuzzy'],
    \   },
    \   'lsp': {
    \       'mark': 'LSP',
    \       'minAutoCompleteLength': 1,
    \       'forceCompletionPattern': '\.\w*|:\w*|->\w*',
    \   },
    \   'buffer': {
    \       'mark': 'BUFFER',
    \       'maxItems': 3,
    \   },
    \   'omnisharp-vim': {
    \       'mark': 'OMNI',
    \       'minAutoCompleteLength': 1,
    \       'maxItems': 30,
    \   },
    \   'ultisnips': {
    \       'mark': 'SNIP',
    \       'maxItems': 5
    \   },
	\   'vsnip': {
	\       'mark': 'SNIP',
    \       'maxItems': 5,
	\   },
    \ },
    \ 'sourceParams': {
    \   'lsp': {
    \       'enableResolveItem': v:true,
    \       'enableAdditionalTextEdit': v:true,
    \       'snippetEngine': denops#callback#register({
    \           body -> vsnip#anonymous(body)
    \       }),
    \   },
    \   'buffer': {
    \       'requireSameFiletype': v:false,
    \       'limitBytes': 5000000,
    \       'fromAltBuf': v:true,
    \       'forceCollect': v:true,
    \   },
    \   'enableResolveItem': v:true,
    \   'enableAdditionalTextEdit': v:true,
    \ }
\ })

inoremap <expr> <TAB>
    \ pumvisible() ? '<C-n>' :
    \ (col('.') <= 1 <Bar><Bar> getline('.')[col('.') - 2] =~# '\s') ?
    \ '<TAB>' : ddc#map#manual_complete()

" <S-TAB>: completion back.
inoremap <expr><S-TAB>  pumvisible() ? '<C-p>' : '<C-h>'

" Press enter to confirm the selection
inoremap <expr> <cr>    pumvisible() ? "\<C-y>" : "\<cr>"

" Use ddc.
call ddc#enable()
" Enable pop up previews
call popup_preview#enable()
