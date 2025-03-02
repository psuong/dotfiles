local base_keybinds = {};

vim.keymap.set("n", "j", "gj");
vim.keymap.set("n", "k", "gk");
vim.g.mapleader = ",";

local opts = { noremap = true, silent = true };
vim.api.nvim_set_keymap("v", "<C-c>", "\"*y :let @+=@*<CR>", opts);
vim.api.nvim_set_keymap("v", "<C-s-v>", "\"+p", opts);
vim.api.nvim_set_keymap("n", "<C-s-v>", "\"+p", opts);

return base_keybinds;
