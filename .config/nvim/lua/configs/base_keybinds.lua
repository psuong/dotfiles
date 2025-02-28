local base_keybinds = {};

vim.keymap.set("n", "j", "gj");
vim.keymap.set("n", "k", "gk");
vim.g.mapleader = ",";

vim.api.nvim_set_keymap("v", "<c-c>", '"*y :let @+=@*<CR>', { noremap = true, silent = true });
vim.api.nvim_set_keymap("v", "<c-v>", '"+p', { noremap = true, silent = true });

return base_keybinds;
