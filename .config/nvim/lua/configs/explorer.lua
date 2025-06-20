local explorer = {};

--------------
-- Vim Clap --
--------------
vim.g.clap_enable_icon = 1;
vim.g.clap_plugin_experimental = true;
vim.g.clap_layout = {
    relative = "editor"
};
vim.g.clap_theme = "material_design_dark";
vim.g.clap_open_preview = "always";
vim.g.clap_on_move_delay = 0;

local noremap_silent = { noremap = true, silent = true };
vim.api.nvim_set_keymap("n", "<C-p>", ":Clap files<CR>", noremap_silent);
vim.api.nvim_set_keymap("n", "<C-g>", ":Clap grep<CR>", noremap_silent);
vim.api.nvim_set_keymap("n", "<C-b>", ":Clap buffers<CR>", noremap_silent);

----------
-- Fern --
----------
vim.g.loaded_netrw = 1;
vim.g.loaded_netrwPlugin = 1;
vim.api.nvim_set_keymap("n", "<C-n>", ":Fern . -drawer -toggle -width=35<CR>", { noremap = true, silent = true });
vim.g["fern#disable_default_mappings"] = false;
vim.g["fern#renderer"] = "nvim-web-devicons";
vim.g["fern#hide_cursor"] = 1;

vim.api.nvim_create_autocmd("FileType", {
    pattern = "fern",
    callback = function()
        local opts = { noremap = true, silent = true, buffer = true };
        vim.keymap.set("n", "o", "<Plug>(fern-action-open)", opts);
        vim.keymap.set("n", "c", "<Plug>(fern-action-collapse)", opts);
        vim.keymap.set("n", "r", "<Plug>(fern-action-rename)", opts);
        vim.keymap.set("n", "d", "<Plug>(fern-action-remove)", opts);
        vim.keymap.set("n", "n", "<Plug>(fern-action-new-file)", opts);
        vim.keymap.set("n", "N", "<Plug>(fern-action-new-dir)", opts);
        vim.keymap.set("n", "R", "<Plug>(fern-action-reload:all)", opts);
    end,
});

vim.api.nvim_create_augroup("FernPalette", { clear = true });
vim.api.nvim_create_autocmd("FileType", {
    group = "FernPalette",
    pattern = "fern",
    callback = function()
        vim.fn["glyph_palette#apply"]();
    end,
});

vim.api.nvim_create_autocmd("VimEnter", {
    callback = function()
        if vim.fn.argc() == 0 then
            vim.cmd("Clap files");
        end
    end
});

return explorer;
