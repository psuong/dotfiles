--------------
-- Vim Clap --
--------------
vim.g.clap_enable_icon = 1;
vim.g.clap_plugin_experimental = true;
vim.g.clap_layout = {
    relative = "editor"
};
vim.g.clap_theme = "material_design_dark";

-- Nvim Tree
-- disable netrw at the very start of your init.lua
vim.g.loaded_netrw = 1;
vim.g.loaded_netrwPlugin = 1;

-- optionally enable 24-bit colour
vim.opt.termguicolors = true;

local function my_on_attach(bufnr)
    local api = require("nvim-tree.api");

    local function opts(desc)
        return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true };
    end

    -- default mappings
    api.config.mappings.default_on_attach(bufnr);

    -- custom mappings
    vim.keymap.set("n", "l", api.node.open.edit, opts("Open"));
    vim.keymap.set("n", "?", api.tree.toggle_help, opts("Help"));
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
    if buffer_name ~= nil then
        return string.find(buffer_name, value);
    else
        return false;
    end
end

local function hide_cursor()
    vim.cmd("set guicursor+=a:Cursor/lCursor"); -- Hide the cursor
    vim.cmd("hi Cursor blend=100");             -- Set the blend to 100, which is the bg
end

local function restore_cursor()
    -- Just picked Vim"s default settings
    vim.cmd("set guicursor=n-v-c-sm:block,i-ci-ve:ver25,r-cr-o:hor20");

    -- Set the blend to 0, which is the fg
    vim.cmd("hi Cursor blend=0");
end

-- Create autocommands to manage cursor visibility in nvim-tree
vim.api.nvim_create_autocmd("BufEnter", {
    pattern = "NvimTree_*",
    callback = hide_cursor
});

vim.api.nvim_create_autocmd("BufLeave", {
    pattern = "NvimTree_*",
    callback = restore_cursor
});

vim.api.nvim_create_autocmd("CmdlineEnter", {
    callback = restore_cursor
});

vim.api.nvim_create_autocmd("CmdlineLeave", {
    callback = function()
        if is_buffer("NvimTree") then
            hide_cursor();
        else
            restore_cursor();
        end
    end
});

-----------------
-- Keybindings --
-----------------
local noremap_silent = { noremap = true, silent = true }
vim.api.nvim_set_keymap("n", "<C-p>", ":Clap files<CR>", noremap_silent);
vim.api.nvim_set_keymap("n", "<C-g>", ":Clap grep<CR>", noremap_silent);
vim.api.nvim_set_keymap("n", "<C-b>", ":Clap buffers<CR>", noremap_silent);
vim.api.nvim_set_keymap("n", "<C-n>", ":NvimTreeToggle<CR>", noremap_silent);

vim.api.nvim_set_keymap("n", "<A-.>", ":BufferNext<CR>", noremap_silent);
vim.api.nvim_set_keymap("n", "<A-,>", ":BufferPrevious<CR>", noremap_silent);
vim.api.nvim_set_keymap("n", "<A-1>", ":BufferGoto 1<CR>", noremap_silent);
vim.api.nvim_set_keymap("n", "<A-2>", ":BufferGoto 2<CR>", noremap_silent);
vim.api.nvim_set_keymap("n", "<A-3>", ":BufferGoto 3<CR>", noremap_silent);
vim.api.nvim_set_keymap("n", "<A-4>", ":BufferGoto 4<CR>", noremap_silent);
vim.api.nvim_set_keymap("n", "<A-5>", ":BufferGoto 5<CR>", noremap_silent);
vim.api.nvim_set_keymap("n", "<A-6>", ":BufferGoto 6<CR>", noremap_silent);
vim.api.nvim_set_keymap("n", "<A-7>", ":BufferGoto 7<CR>", noremap_silent);
vim.api.nvim_set_keymap("n", "<A-8>", ":BufferGoto 8<CR>", noremap_silent);
vim.api.nvim_set_keymap("n", "<A-9>", ":BufferGoto 9<CR>", noremap_silent);
vim.api.nvim_set_keymap("n", "<A-0>", ":BufferLast<CR>", noremap_silent);
