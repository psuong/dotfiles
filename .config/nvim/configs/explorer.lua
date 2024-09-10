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

-- Checks if the buffer is whatever name we're fuzzy matching
local function is_buffer(value)
    local buffer = vim.api.nvim_get_current_buf();
    local buffer_name = vim.api.nvim_buf_get_name(buffer);
    return string.find(buffer_name, value);
end

local function hide_cursor()
    vim.cmd("set guicursor+=a:Cursor/lCursor"); -- Hide the cursor
    vim.cmd("hi Cursor blend=100");             -- Set the blend to 100, which is the bg
end

local function restore_cursor()
    -- Just picked Vim's default settings
    vim.cmd('set guicursor=n-v-c-sm:block,i-ci-ve:ver25,r-cr-o:hor20');

    -- Set the blend to 0, which is the fg
    vim.cmd('hi Cursor blend=0');
end

-- Create autocommands to manage cursor visibility in nvim-tree
vim.api.nvim_create_autocmd("BufEnter", {
    pattern = "NvimTree_*",
    callback = hide_cursor
})

vim.api.nvim_create_autocmd("BufLeave", {
    pattern = "NvimTree_*",
    callback = restore_cursor
})

vim.api.nvim_create_autocmd("CmdlineEnter", {
    callback = restore_cursor
})

vim.api.nvim_create_autocmd("CmdlineLeave", {
    callback = function ()
        if is_buffer("NvimTree") then
            hide_cursor();
        else
            restore_cursor();
        end
    end
})

-----------------
-- Keybindings --
-----------------
vim.api.nvim_set_keymap("n", "<C-p>", ":Clap files<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<C-g>", ":Clap grep<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<C-b>", ":Clap buffers<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<C-n>", ":NvimTreeToggle<CR>", { noremap = true, silent = true })
