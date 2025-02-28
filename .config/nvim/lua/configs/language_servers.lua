local language_servers = {};

----------------
-- File types --
----------------
vim.filetype.add({
    extension = {
        slang = "slang",
        shaderslang = "slang",
        hlsl = "hlsl"
    }
});

--------------
-- Vim Doge --
--------------
vim.g.doge_enable_mappings = 0;
-- Generate comment for current line
vim.keymap.set("n", "<Leader>d", "<Plug>(doge-generate)");

-- Interactive mode comment todo-jumping
vim.keymap.set("n", "<Tab>", "<Plug>(doge-comment-jump-forward)");
vim.keymap.set("n", "<S-Tab>", "<Plug>(doge-comment-jump-backward)");
vim.keymap.set("i", "<Tab>", "<Plug>(doge-comment-jump-forward)");
vim.keymap.set("i", "<S-Tab>", "<Plug>(doge-comment-jump-backward)");
vim.keymap.set("x", "<Tab>", "<Plug>(doge-comment-jump-forward)");
vim.keymap.set("x", "<S-Tab>", "<Plug>(doge-comment-jump-backward)");

--------------------------
-- Rust crates.io Setup --
--------------------------
local function lazy_load_crates()
    vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
        pattern = "Cargo.toml",
        callback = function()
            require("crates").setup();
        end
    });
end
lazy_load_crates();

--------------
-- Snippets --
--------------
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

require("aerial").setup({
    -- Priority list of preferred backends for aerial.
    -- This can be a filetype map (see :help aerial-filetype-map)
    backends = { "treesitter", "lsp", "markdown", "asciidoc", "man" },

    layout = {
        max_width = { 40, 0.2 },
        width = nil,
        min_width = 30,
        -- Enum: prefer_right, prefer_left, right, left, float
        default_direction = "prefer_right",

        -- Determines where the aerial window will be opened
        --   edge   - open aerial at the far right/left of the editor
        --   window - open aerial to the right/left of the current window
        placement = "window",
        resize_to_content = true,
        preserve_equality = false,
    },
});
vim.keymap.set("n", "<S-i>", "<cmd>AerialToggle!<CR>");

---------
-- LSP --
---------
local function toggle_inlay_hint()
    vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled());
end

local capabilities = require("ddc_source_lsp").make_client_capabilities();
local path_helper = require("helpers.path_helper");

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
    vim.keymap.set("n", ".", vim.diagnostic.goto_next, { noremap = true, silent = true });
    vim.keymap.set("n", ",", vim.diagnostic.goto_prev, { noremap = true, silent = true });
    local_map("n", "<Leader>e", function()
        vim.diagnostic.open_float(nil, { focus = false });
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
    cmd = { "OmniSharp", "--languageserver", "--hostPID", tostring(vim.fn.getpid()) },
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

require("lspconfig").slangd.setup({
    capabilities = capabilities,
    filetypes = { "slang", "shaderslang", "hlsl" },
    settings = {
        slang = {
            predefinedMacros = { "MY_VALUE_MACRO=1" },
            inlayHints = {
                deducedTypes = true,
                parameterNames = true,
            },
            format = {
                clangFormatLocation = "clang-format"
            },
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
    },
});

require("lspconfig").lua_ls.setup({
    capabilities = capabilities,
    cmd = { "lua-language-server" },
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

require("lspconfig").clangd.setup({
    capabilities = capabilities,
    cmd = { "clangd" },
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

---------
-- DDC --
---------
local patch_ddc = vim.fn["ddc#custom#patch_global"];
vim.cmd([[
call ddc#custom#patch_global('filterParams', {
  \   'matcher_fuzzy': {
  \     'splitMode': 'word'
  \   },
  \   'converter_fuzzy': {
  \     'hlGroup': 'SpellBad'
  \   }
  \ })
]]);
patch_ddc({
    ui = "native",
    sources = { "lsp", "vsnip" },
    sourceOptions = {
        ["_"] = {
            matchers = { "matcher_fuzzy" },
            sorters = { "sorter_fuzzy" },
            converters = { "converter_fuzzy" },
        },
        vsnip = {
            mark = "SNIP",
            maxItems = 5,
        },
        lsp = {
            mark = "LSP",
            forceCompletionPattern = [[\.\w*|:\w*|->\w*]],
            maxItems = 20,
        },
    },
    sourceParams = {
        lsp = {
            enableResolveItem = true,
            enableAdditionalTextEdit = true,
            snippetEngine = vim.fn["denops#callback#register"](function(body)
                return vim.fn["vsnip#anonymous"](body)
            end),
        },
        enableResolveItem = true,
        enableAdditionalTextEdit = true,
    },
});

-- Tab Support
vim.keymap.set("i", "<Tab>", function()
    if vim.fn.pumvisible() == 1 then
        return "<C-n>";
    elseif vim.fn.col(".") <= 1 or vim.fn.getline("."):sub(vim.fn.col(".") - 1, vim.fn.col(".") - 1):match("%s") then
        return "<Tab>";
    else
        return vim.fn["ddc#map#manual_complete"]();
    end
end, { expr = true, noremap = true });

-- Shift Tab Support to go backwards
vim.keymap.set("i", "<S-Tab>", function()
    return vim.fn.pumvisible() == 1 and "<C-p>" or "<C-h>"
end, { expr = true, noremap = true });

-- Confirm selection with enter.
vim.keymap.set("i", "<CR>", function()
    return vim.fn.pumvisible() == 1 and "<C-y>" or "<CR>"
end, { expr = true, noremap = true });

-- Enable ddc and the completion menu.
vim.fn["ddc#enable"]();
vim.fn["popup_preview#enable"]();

vim.g.signature_help_confg = {
    contentsStyle = "full",
    viewStyle = "floating"
}
vim.fn["signature_help#enable"]();

return language_servers;
