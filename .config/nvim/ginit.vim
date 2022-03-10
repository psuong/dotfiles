" Enable Mouse
set mouse=a
call GuiWindowMaximized(1)

" Set Editor Font
if exists(':GuiFont')
    " Use GuiFont! to ignore font errors
    GuiFont! UbuntuMono\ Nerd\ Font:h11
    " GuiFont! {font_name}:h{size}
endif

" Disable GUI Tabline
if exists(':GuiTabline')
    GuiTabline 0
endif

" Disable GUI Popupmenu
if exists(':GuiPopupmenu')
    GuiPopupmenu 0
endif

" Disable GUI ScrollBar
if exists(':GuiScrollBar')
    GuiScrollBar 0
endif

if exists('g:GuiLoaded')
    if exists(':GuiAdaptiveColor')
        GuiAdaptiveColor 1
    endif

    if exists(':GuiRenderLigatures')
        GuiRenderLigatures 1
    endif
endif

" Right Click Context Menu (Copy-Cut-Paste)
nnoremap <silent><RightMouse> :call GuiShowContextMenu()<CR>
inoremap <silent><RightMouse> <Esc>:call GuiShowContextMenu()<CR>
xnoremap <silent><RightMouse> :call GuiShowContextMenu()<CR>gv
snoremap <silent><RightMouse> <C-G>:call GuiShowContextMenu()<CR>gv
