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
    \   <Plug>(fern-my-expand-or-collapse)
    \   fern#smart#leaf(
    \     "\<Plug>(fern-action-collapse)",
    \     "\<Plug>(fern-action-expand)",
    \     "\<Plug>(fern-action-collapse)",
    \   )
    
    nmap <buffer><nowait> <enter> <Plug>(fern-my-expand-or-collapse)
    " ----------------------------------------------------------------
    " Bind opening and closing the fern buffer
    " ----------------------------------------------------------------
    nmap <C-n> :Fern . -drawer -toggle -width=35<CR>
    nmap <C-m> :FernDo close<CR>
    
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
" Search Window
" ----------------------------------------------------------------------
let g:clap_enable_icon = 1
let g:clap_plugin_experimental = v:true
nmap <c-p> :Clap files<CR>
nmap <c-g> :Clap grep<CR>
let g:clap_layout = { 
\   'relative': 'editor'
\ }

" ----------------------------------------------------------------------
" Buffer View
" ----------------------------------------------------------------------
lua <<EOF

local opts = {noremap = true}
local map = vim.keymap.set
-- Setup
require("buffer_manager").setup({
    select_menu_item_commands = {
        v = {
            key = "<C-v>",
            command = "vsplit"
        },
        h = {
            key = "<C-h>",
            command = "split"
        }
    },
    focus_alternate_buffer = false,
    short_file_names = true,
    short_term_names = true,
    loop_nav = false,
    highlight = 'Normal:BufferManagerBorder',
    win_extra_options = {
        winhighlight = 'Normal:BufferManagerNormal',
    },
})
-- Navigate buffers bypassing the menu
local bmui = require("buffer_manager.ui")
local keys = '1234567890'
for i = 1, #keys do
    local key = keys:sub(i,i)
    map(
        'n',
        string.format('<leader>%s', key),
        function () bmui.nav_file(i) end,
        opts
    )
end
-- Just the menu
map({ 't', 'n' }, '<C-b>', bmui.toggle_quick_menu, opts)
-- Open menu and search
map({ 't', 'n' }, '<C-v>', function ()
    bmui.toggle_quick_menu()
    -- wait for the menu to open
    vim.defer_fn(function ()
      vim.fn.feedkeys('/')
    end, 50)
end, opts)
-- Next/Prev
map('n', '<M-j>', bmui.nav_next, opts)
map('n', '<M-k>', bmui.nav_prev, opts)

EOF