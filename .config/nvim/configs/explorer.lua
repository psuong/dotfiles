--------------
-- Vim Clap --
--------------
vim.g.clap_enable_icon = 1;
vim.g.clap_plugin_experimental = true;
vim.g.clap_layout = {
    relative = "editor"
};

-- Nvim Tree
-- disable netrw at the very start of your init.lua
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- optionally enable 24-bit colour
vim.opt.termguicolors = true

local function my_on_attach(bufnr)
    local api = require "nvim-tree.api"

    local function opts(desc)
        return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
    end

    -- default mappings
    api.config.mappings.default_on_attach(bufnr)

    -- custom mappings
    vim.keymap.set('n', 'l', api.node.open.edit, opts('Open'))
end

require("nvim-tree").setup({
    sort = {
        sorter = "case_sensitive",
    },
    view = {
        width = 40,
    },
    renderer = {
        group_empty = true,
    },
    filters = {
        dotfiles = false,
        custom = { ".git", ".meta" }
    },
    on_attach = my_on_attach
})

local buffer_nvim_tree = vim.api.nvim_create_augroup("NvimTree", { clear = true });


-----------------
-- Keybindings --
-----------------
vim.api.nvim_set_keymap("n", "<C-p>", ":Clap files<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<C-g>", ":Clap grep<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<C-b>", ":Clap buffers<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<C-n>", ":NvimTreeToggle<CR>", { noremap = true, silent = true })
