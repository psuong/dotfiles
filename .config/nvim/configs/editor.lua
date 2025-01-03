local cast = require("helpers.cast");

vim.opt.autoread = true;             -- Automatically reload the buffer when changed outside of vim
vim.opt.hidden = true;               -- Allows you to switch the buffer without having to write/save it first
vim.opt.swapfile = false;            -- Don"t generate swap files
vim.cmd("syntax manual");            -- Set the syntax manually for highlighting

vim.cmd("filetype plugin indent on") -- Detect the filetypes and allow indentation based on the file types
-- Font Encoding
vim.opt.encoding = "UTF-8";

-- Visual Studio Like Settings
vim.opt.expandtab = true; -- Tabs are spaces
vim.opt.tabstop = 4;      -- # of spaces per tab
vim.opt.shiftwidth = 4;   -- Make it consistent with tab stop
vim.opt.smartindent = true;
vim.opt.signcolumn = "yes";
vim.opt.title = true;
vim.opt.linespace = 1;

vim.opt.number = true;
vim.opt.colorcolumn = "100";
vim.opt.cursorline = true;
vim.opt.showcmd = true;
vim.opt.showmode = false;
vim.opt.laststatus = 3; -- Disable the status bar
vim.opt.completeopt = "menuone,noselect";

vim.opt.termguicolors = cast.as_bool(vim.fn.has("termguicolors"));

vim.cmd("set guifont=UbuntuMono\\ Nerd\\ Font\\ Propo:h12")

-- Set splitting to vertical by default
vim.opt.diffopt:append("vertical");

vim.opt.list = false;
vim.opt.backspace = { "indent", "eol", "start" }

----------------------
-- Smooth scrolling --
----------------------
require("neoscroll").setup();

------------
-- Glyphs --
------------
require("nvim-web-devicons").get_icons();

-----------
-- Theme --
-----------
vim.o.background = "dark";

-- Default options:
require("gruvbox").setup({
    terminal_colors = true, -- add neovim terminal colors
    undercurl = true,
    underline = true,
    bold = false,
    italic = {
        strings = false,
        emphasis = true,
        comments = false,
        operators = false,
        folds = true,
    },
    strikethrough = true,
    invert_selection = false,
    invert_signs = false,
    invert_tabline = false,
    invert_intend_guides = false,
    inverse = true, -- invert background for search, diffs, statuslines and errors
    contrast = "",  -- can be "hard", "soft" or empty string
    palette_overrides = {},
    overrides = {},
    dim_inactive = false,
    transparent_mode = false,
})
vim.cmd("colorscheme gruvbox")

local highlight = {
    "RainbowRed",
    "RainbowYellow",
    "RainbowBlue",
    "RainbowOrange",
    "RainbowGreen",
    "RainbowViolet",
    "RainbowCyan",
}

local hooks = require("ibl.hooks")
-- create the highlight groups in the highlight setup hook, so they are reset
-- every time the colorscheme changes
hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
    vim.api.nvim_set_hl(0, "RainbowRed", { fg = "#E06C75" })
    vim.api.nvim_set_hl(0, "RainbowYellow", { fg = "#E5C07B" })
    vim.api.nvim_set_hl(0, "RainbowBlue", { fg = "#61AFEF" })
    vim.api.nvim_set_hl(0, "RainbowOrange", { fg = "#D19A66" })
    vim.api.nvim_set_hl(0, "RainbowGreen", { fg = "#98C379" })
    vim.api.nvim_set_hl(0, "RainbowViolet", { fg = "#C678DD" })
    vim.api.nvim_set_hl(0, "RainbowCyan", { fg = "#56B6C2" })
end)

-- -------------------
-- -- Indent guides --
-- -------------------
require("ibl").setup { indent = {
    highlight = highlight,
    char = "│"
} }

-- Define a highlight group for TODO comments
vim.cmd("highlight Todo cterm=bold gui=bold");

-- Create an autocmd to highlight TODO comments
vim.api.nvim_create_autocmd("Syntax", {
  pattern = "*",
  command = "match Todo /TODO/",
});

------------------------------------
-- Treesitter/Syntax Highlighting --
------------------------------------
require("nvim-treesitter.install").compilers = { "clang", "gcc" }
require("nvim-treesitter.configs").setup {
    -- A list of parser names, or "all"
    ensure_installed = {
        "c",
        "c_sharp",
        "rust",
        "hlsl",
        "glsl",
        "vimdoc",
        "powershell",
        "yaml",
        "toml"
    },

    -- Install parsers synchronously (only applied to `ensure_installed`)
    sync_install = false,

    highlight = {
        -- `false` will disable the whole extension
        enable = true,
        -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
        -- Set this to `true` if you depend on "syntax" being enabled (like for indentation).
        -- Using this option may slow down your editor, and you may see some duplicate highlights.
        -- Instead of true it can also be a list of languages
        additional_vim_regex_highlighting = false,
    },
}

------------
-- Tagbar --
------------
vim.g.tagbar_foldlevel = 3;
vim.g.tagbar_iconchars = { "▸", "▾" };
vim.g.tagbar_show_tag_linenumbers = 1;
vim.g.tagbar_scopestrs = {
    ["class"] = "\u{f0e8}",
    ["const"] = "\u{f8ff}",
    ["constant"] = "\u{f8ff}",
    ["enum"] = "\u{f702}",
    ["field"] = "\u{f30b}",
    ["func"] = "\u{1d453}",
    ["method"] = "\u{1d453}",
    ["function"] = "\u{1d453}",
    ["getter"] = "-->",
    ["implementation"] = "\u{f776}",
    ["interface"] = "\u{f7fe}",
    ["map"] = "\u{fb44}",
    ["member"] = "\u{f02b}",
    ["setter"] = "<--",
    ["variable"] = "\u{f71b}",
    ["namespace"] = "\u{2026}",
    ["struct"] = "\u{03C8}"
};

vim.g.tagbar_visbility_symbols = {
    public = "+",
    protected = "*",
    private = "-"
};

-- Enable syntax for the tab bar buffer
local function enable_tagbar_syntax_coloring()
    -- Get the current buffer name
    local buffer_name = vim.api.nvim_buf_get_name(0);

    if string.find(buffer_name, "Tagbar") then
        vim.cmd("syntax enable");
    end
end

local buffer_enter_group = vim.api.nvim_create_augroup("BufferEnter", { clear = true });

vim.api.nvim_create_autocmd("BufEnter", {
    group = buffer_enter_group,
    pattern = "*",
    callback = enable_tagbar_syntax_coloring,
});

-----------------
-- Keybindings --
-----------------
vim.keymap.set("n", "j", "gj");
vim.keymap.set("n", "k", "gk");
vim.g.mapleader = ",";

vim.keymap.set("n", "[c", function()
    require("treesitter-context").go_to_context();
end, { silent = true });

-- Tagbar
vim.api.nvim_set_keymap("n", "<S-o>", ":TagbarToggle<CR>", { noremap = true, silent = true });

-- For vim doge I"m using default mappings, nothing special
vim.g.doge_enable_mappings = 0;
-- Generate comment for current line
vim.keymap.set("n", "<Leader>d", "<Plug>(doge-generate)")

-- Interactive mode comment todo-jumping
vim.keymap.set("n", "<TAB>", "<Plug>(doge-comment-jump-forward)");
vim.keymap.set("n", "<S-TAB>", "<Plug>(doge-comment-jump-backward)");
vim.keymap.set("i", "<TAB>", "<Plug>(doge-comment-jump-forward)");
vim.keymap.set("i", "<S-TAB>", "<Plug>(doge-comment-jump-backward)");
vim.keymap.set("x", "<TAB>", "<Plug>(doge-comment-jump-forward)");
vim.keymap.set("x", "<S-TAB>", "<Plug>(doge-comment-jump-backward)");

-- Consider this for code formatting, hopefully it respects
-- https://github.com/lukas-reineke/lsp-format.nvim
vim.cmd([[
" NOTE: You can use other key to expand snippet.

" Expand
imap <expr> <C-j>   vsnip#expandable()  ? "<Plug>(vsnip-expand)"         : "<C-j>"
smap <expr> <C-j>   vsnip#expandable()  ? "<Plug>(vsnip-expand)"         : "<C-j>"

" Expand or jump
imap <expr> <C-k>   vsnip#available(1)  ? "<Plug>(vsnip-expand-or-jump)" : "<C-l>"
smap <expr> <C-k>   vsnip#available(1)  ? "<Plug>(vsnip-expand-or-jump)" : "<C-l>"

" Jump forward or backward
imap <expr> <C-j>   vsnip#jumpable(1)   ? "<Plug>(vsnip-jump-next)"      : "<Tab>"
smap <expr> <C-j>   vsnip#jumpable(1)   ? "<Plug>(vsnip-jump-next)"      : "<Tab>"
imap <expr> <C-k> vsnip#jumpable(-1)  ? "<Plug>(vsnip-jump-prev)"      : "<S-Tab>"
smap <expr> <C-k> vsnip#jumpable(-1)  ? "<Plug>(vsnip-jump-prev)"      : "<S-Tab>"

" Select or cut text to use as $TM_SELECTED_TEXT in the next snippet.
" See https://github.com/hrsh7th/vim-vsnip/pull/50
nmap        s   <Plug>(vsnip-select-text)
xmap        s   <Plug>(vsnip-select-text)
nmap        S   <Plug>(vsnip-cut-text)
xmap        S   <Plug>(vsnip-cut-text)
]]);

local function toggle_inlay_hint()
    vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled());
end

local capabilities = require("ddc_source_lsp").make_client_capabilities();
local path_helper = require("helpers.path_helper");

--- Get the servers if they're not on the path
local omnisharp_bin = path_helper.expand_tilde("~/sources/language-servers/omnisharp-win-x64/OmniSharp.exe");
local lua_ls_bin = path_helper.expand_tilde("~/sources/language-servers/lua-language-server/bin/lua-language-server.exe");

--- The current buffer
local current_buffer = nil;

local local_map = function(mode, keys, func, desc)
    vim.keymap.set(mode, keys, func, { buffer = current_buffer, desc = desc });
end

local function common_keybindings()
    local_map("n", "<Leader>ti", toggle_inlay_hint, "Toggle inlay hints");
    local_map("n", "<Leader>ra", vim.lsp.buf.code_action, "Run code actions");
    local_map("n", "<Leader>ga", vim.lsp.buf.declaration, "Goto declaration");
    local_map("n", "<Leader>nm", vim.lsp.buf.rename, "Rename symbol");
    local_map("n", "<Leader>cf", vim.lsp.buf.format, "Run code formatting");
    local_map("n", "<Leader>pd", vim.lsp.buf.hover, "Preview info above cursor");
    vim.keymap.set("n", ".", vim.diagnostic.goto_next, { noremap = true, silent = true })
    vim.keymap.set("n", ",", vim.diagnostic.goto_prev, { noremap = true, silent = true })
    local_map("n", "<Leader>e", function()
        vim.diagnostic.open_float(nil, { focus = false })
    end, 'Show diagnostics float')
end

local function configurable_functionality(defs_callback, type_defs_callback, refs_callback, impl_callback)
    local_map("n", "<Leader>gd", defs_callback, "Go to definition");
    local_map("n", "<Leader>go", type_defs_callback, "Go to type definition");
    local_map("n", "<Leader>fu", refs_callback, "Find all references");
    local_map("n", "<Leader>fi", impl_callback, "Find all implementations");
end

require("lspconfig").omnisharp.setup({
    capabilities = capabilities,
    cmd = { omnisharp_bin, "--languageserver", "--hostPID", tostring(vim.fn.getpid()) },
    on_attach = function(_, bufnr)
        current_buffer = bufnr;
        common_keybindings();
        local omnisharp_extended = require("omnisharp_extended");
        configurable_functionality(
            omnisharp_extended.lsp_definition,
            omnisharp_extended.lsp_type_definition,
            omnisharp_extended.clap_lsp_references,
            omnisharp_extended.lsp_implementation);

        local lsp_ui = require("helpers.lsp_ui");
        vim.ui.select = lsp_ui.on_select;
        vim.lsp.inlay_hint.enable(true);
        vim.diagnostic.config({ virtual_text = false });
    end,
});

require("powershell").setup({
    capabilities = capabilities,
    bundle_path = path_helper.expand_tilde("~/sources/language-servers/PowerShellEditorServices"),
    server = {
        on_attach = function(_, bufnr)
            current_buffer = bufnr;
            common_keybindings();
            configurable_functionality(
                vim.lsp.buf.definition,
                vim.lsp.buf.type_definition,
                vim.lsp.buf.references,
                vim.lsp.buf.implementation);

            local lsp_ui = require("helpers.lsp_ui");
            vim.ui.select = lsp_ui.on_select;
            vim.lsp.handlers["textDocument/references"] = lsp_ui.clap_references_ui;
        end
    }
});

require("lspconfig").lua_ls.setup({
    capabilities = capabilities,
    cmd = { lua_ls_bin },
    on_init = function(client)
        local path = client.workspace_folders[1].name
        if vim.loop.fs_stat(path .. '/.luarc.json') or vim.loop.fs_stat(path .. '/.luarc.jsonc') then
            return
        end

        client.config.settings.Lua = vim.tbl_deep_extend('force', client.config.settings.Lua, {
            runtime = {
                -- Tell the language server which version of Lua you're using
                -- (most likely LuaJIT in the case of Neovim)
                version = "LuaJIT"
            },
            -- Make the server aware of Neovim runtime files
            workspace = {
                checkThirdParty = false,
                library = {
                    vim.env.VIMRUNTIME
                    -- Depending on the usage, you might want to add additional paths here.
                    -- "${3rd}/luv/library"
                    -- "${3rd}/busted/library",
                }
                -- or pull in all of 'runtimepath'. NOTE: this is a lot slower
                -- library = vim.api.nvim_get_runtime_file("", true)
            }
        })
    end,
    on_attach = function(_, bufnr)
        current_buffer = bufnr;
        common_keybindings();
        configurable_functionality(
            vim.lsp.buf.definition,
            vim.lsp.buf.type_definition,
            vim.lsp.buf.references,
            vim.lsp.buf.implementation);

        local lsp_ui = require("helpers.lsp_ui");
        vim.ui.select = lsp_ui.on_select;
        vim.lsp.handlers["textDocument/references"] = lsp_ui.clap_references_ui;
    end,
    settings = {
        Lua = {}
    }
});

-- Rust Analyzer is installed using rustup
vim.g.rustaceanvim = {
    server = {
        on_attach = function(_, bufnr)
            current_buffer = bufnr;
            vim.diagnostic.config({ virtual_text = false });

            common_keybindings();
            configurable_functionality(
                vim.lsp.buf.definition,
                vim.lsp.buf.type_definition,
                vim.lsp.buf.references,
                vim.lsp.buf.implementation);
            local lsp_ui = require("helpers.lsp_ui");
            vim.ui.select = lsp_ui.on_select;
            vim.lsp.inlay_hint.enable(true);
            vim.lsp.handlers["textDocument/references"] = lsp_ui.clap_references_ui;
        end,
        default_settings = {
            ['rust-analyzer'] = {},
        },
    }
};

vim.cmd([[
call ddc#custom#patch_global({
    \ 'ui': 'native',
    \ 'sources': [ 'lsp', 'vsnip' ],
    \ 'sourceOptions': {
    \   '_': {
    \       'matchers': ['matcher_fuzzy'],
    \       'sorters' : ['sorter_fuzzy'],
    \       'converters' : ['converter_fuzzy'],
    \   },
    \   'lsp': {
    \       'mark': 'LSP',
    \       'minAutoCompleteLength': 1,
    \       'forceCompletionPattern': '\.\w*|:\w*|->\w*|.*',
    \       'maxItems': 20,
    \   },
	\   'vsnip': {
	\       'mark': 'SNIP',
    \       'maxItems': 5,
	\   },
    \ },
    \ 'sourceParams': {
    \   'lsp': {
    \       'enableResolveItem': v:true,
    \       'enableAdditionalTextEdit': v:true,
    \       'snippetEngine': denops#callback#register({
    \           body -> vsnip#anonymous(body)
    \       }),
    \   },
    \   'enableResolveItem': v:true,
    \   'enableAdditionalTextEdit': v:true,
    \ }
\ })

inoremap <expr> <TAB>
    \ pumvisible() ? '<C-n>' :
    \ (col('.') <= 1 <Bar><Bar> getline('.')[col('.') - 2] =~# '\s') ?
    \ '<TAB>' : ddc#map#manual_complete()

" <S-TAB>: completion back.
inoremap <expr><S-TAB>  pumvisible() ? '<C-p>' : '<C-h>'

" Press enter to confirm the selection
inoremap <expr> <cr>    pumvisible() ? "\<C-y>" : "\<cr>"

" Use ddc.
call ddc#enable()
" Enable pop up previews
call popup_preview#enable()
]])

vim.g.signature_help_confg = {
    contentsStyle = "full",
    viewStyle = "floating"
}
vim.fn["signature_help#enable"]()

----------------
-- File types --
----------------
vim.cmd([[
    autocmd BufNewFile,BufRead *.hlsl set filetype=hlsl
]]);

-------------------
-- Terminal Cmds --
-------------------
local function get_window_for_buffer(buf)
    for _, win in ipairs(vim.api.nvim_list_wins()) do
        if vim.api.nvim_win_get_buf(win) == buf then
            return win;
        end
    end
    return nil;
end

local_map("n", "T", function()
    local current_buf = vim.api.nvim_get_current_buf();
    local height = 20;

    -- If it is a terminal, close it
    if vim.bo[current_buf].buftype == "terminal" then
        local terminal_windows = {};
        for _, win in ipairs(vim.api.nvim_list_wins()) do
            if vim.api.nvim_win_get_buf(win) == current_buf then
                -- Close the window
                vim.api.nvim_win_close(win, true);
            else
                local buf = vim.api.nvim_win_get_buf(win);
                if vim.bo[buf].buftype == "terminal" then
                    table.insert(terminal_windows, win);
                end
            end
        end

        -- Now delete the buffer
        vim.api.nvim_buf_delete(current_buf, { force = true });

        -- Resize all other terminals too b/c it's too jarring
        -- local current_height = vim.api.nvim_win_get_height(vim.api.nvim_get_current_win());
        -- local new_height = math.ceil(current_height * 0.25);
        for _, win in ipairs(terminal_windows) do
            vim.api.nvim_win_set_height(win, height);
        end
    else
        -- If it isn't, create a new terminal
        vim.cmd("belowright split | terminal pwsh");
        current_buf = vim.api.nvim_get_current_buf();
        if vim.bo[current_buf].buftype == "terminal" then
            local window = get_window_for_buffer(vim.api.nvim_get_current_buf());
            if window then
                vim.api.nvim_win_set_height(window, height);
            end
        end
    end
end, "Toggle terminal in a horizontal split");

vim.api.nvim_create_augroup("TerminalMappings", { clear = true })
vim.api.nvim_create_autocmd("TermOpen", {
    pattern = "*",
    callback = function()
        vim.cmd("tnoremap <buffer> <Esc> <C-\\><C-n>")
    end,
});

--------------------------
-- Rust crates.io Setup --
--------------------------
require("crates").setup();
