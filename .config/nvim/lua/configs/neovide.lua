local neovide = {};

if vim.g.neovide then
    vim.g.neovide_position_animation_length = 0;
    vim.g.neovide_scroll_animation_length = 0.0;
    vim.g.neovide_refresh_rate = 60;
    vim.g.neovide_cursor_animation_length = 0.0;
    vim.g.neovide_cursor_trail_size = 0.0;
end

return neovide;
