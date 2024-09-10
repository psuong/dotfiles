local Begin = vim.fn["plug#begin"];
local Plug = vim.fn["plug#"];
local End = vim.fn["plug#end"];

vim.g.plug_url_format = "git@github.com:%s.git";

Begin();

------------------------------------------------------------------------------------------------------------------
-- Editor Styling
------------------------------------------------------------------------------------------------------------------
Plug("ellisonleao/gruvbox.nvim");                                           -- Main Theme
Plug("nvim-tree/nvim-web-devicons");                                        -- Web glyphs
Plug("lukas-reineke/indent-blankline.nvim");                                -- Indent Guides
Plug("romgrk/barbar.nvim");                                                 -- GUI tabs per buffer

Plug("nvim-treesitter/nvim-treesitter", {["do"] = vim.fn["TSUpdate"]});     -- Treesitter parsing
Plug("nvim-treesitter/nvim-treesitter-context");                            -- Show the header based on the node
Plug("preservim/tagbar");                                                   -- ToC for variable/functions                                                  

------------------------------------------------------------------------------------------------------------------
-- Editor Behaviours
------------------------------------------------------------------------------------------------------------------
Plug("karb94/neoscroll.nvim");                                              -- Smooth scrolling
Plug("romgrk/barbar.nvim");                                                 -- Tab navigation
------------------------------------------------------------------------------------------------------------------
-- Searchers
------------------------------------------------------------------------------------------------------------------
Plug("liuchengxu/vim-clap", { ['do'] = vim.fn[":Clap install-binary"] })    -- Fuzzy finder
Plug ("nvim-tree/nvim-web-devicons")
Plug ("nvim-tree/nvim-tree.lua")

End();

-- Source configuration
local path_helper = require("helpers.path_helper");

dofile(path_helper.expand_tilde("~/AppData/Local/nvim/configs/editor.lua"));
dofile(path_helper.expand_tilde("~/AppData/Local/nvim/configs/explorer.lua"));
-- vim.cmd(string.format("source %s", path_helper.expand_tilde("~/AppData/Local/nvim/configs/tree.vim")));