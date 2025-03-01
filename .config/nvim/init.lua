local Begin = vim.fn["plug#begin"];
local Plug = vim.fn["plug#"];
local End = vim.fn["plug#end"];

vim.g.plug_url_format = "git@github.com:%s.git";

Begin();

--------------------
-- Editor Styling --
--------------------
Plug("ellisonleao/gruvbox.nvim");
Plug("nvim-treesitter/nvim-treesitter", {["do"] = vim.fn[":TSUpdate"]});
-- Plug("nvim-treesitter/nvim-treesitter-context");
Plug("echasnovski/mini.indentscope");
Plug("nvim-tree/nvim-web-devicons");
Plug("TheLeoP/fern-renderer-web-devicons.nvim");

-----------------------
-- Editor Behaviours --
-----------------------
-- Plug("karb94/neoscroll.nvim");

---------------
-- Searchers --
---------------
Plug("liuchengxu/vim-clap", {["do"] = vim.fn[":Clap install-binary"]});
Plug("lambdalisue/vim-fern");
Plug("lambdalisue/vim-glyph-palette");

------------------
-- Autocomplete --
------------------
Plug("neovim/nvim-lspconfig");
Plug("stevearc/aerial.nvim");
Plug("vim-denops/denops.vim");
Plug("Shougo/ddc.vim");
Plug("Shougo/ddc-ui-native");
Plug("Shougo/ddc-source-lsp");
Plug("tani/ddc-fuzzy");
Plug("rafamadriz/friendly-snippets");
Plug("hrsh7th/vim-vsnip");
Plug("uga-rosa/ddc-source-vsnip");
Plug("matsui54/denops-popup-preview.vim");
Plug("matsui54/denops-signature_help");
Plug("psuong/omnisharp-extended-lsp.nvim");
-- Plug("psuong/rustaceanvim");
Plug("kkoomen/vim-doge", {["do"] = vim.fn["doge#install()"] });
Plug("TheLeoP/powershell.nvim");

---------------
-- Debuggers --
---------------
Plug("mfussenegger/nvim-dap");
Plug("theHamsta/nvim-dap-virtual-text");

----------------------
-- Package managers --
----------------------
Plug("saecki/crates.nvim");

--------------
-- Profiler --
--------------
Plug("dstein64/vim-startuptime");

End();

require("configs.theme");
require("configs.base_keybinds");
require("configs.syntax");
require("configs.language_servers");
require("configs.debug");
require("configs.terminal");
require("configs.explorer");
