--------------
-- Vim Clap --
--------------
vim.g.clap_enable_icon = 1;
vim.g.clap_plugin_experimental = true;
vim.g.clap_layout = {
    relative = "editor"
};
vim.g.clap_theme = "material_design_dark";

-----------
-- Netrw --
-----------
vim.g.netrw_browse_split = 4;
vim.g.netrw_liststyle = 3;
vim.g.netrw_keepdir = 0;
vim.g.netrw_banner = 0;
vim.g.netrw_winsize = 20;
vim.api.nvim_set_keymap("n", "<C-n>", ":Lexplore<CR>", { noremap = true, silent = true });

vim.opt.termguicolors = true; -- optionally enable 24-bit colour

-----------------
-- Keybindings --
-----------------
local noremap_silent = { noremap = true, silent = true }
vim.api.nvim_set_keymap("n", "<C-p>", ":Clap files<CR>", noremap_silent);
vim.api.nvim_set_keymap("n", "<C-g>", ":Clap grep<CR>", noremap_silent);
vim.api.nvim_set_keymap("n", "<C-b>", ":Clap buffers<CR>", noremap_silent);
