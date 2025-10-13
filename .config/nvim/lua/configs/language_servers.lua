local language_servers = {};

-- Set up a shared server for denops
vim.g.denops_server_addr = "127.0.0.1:32123";

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
imap <expr> <C-j> vsnip#expandable()  ? "<Plug>(vsnip-expand)"         : "<C-j>"
smap <expr> <C-j> vsnip#expandable()  ? "<Plug>(vsnip-expand)"         : "<C-j>"

" Expand or jump
imap <expr> <C-k> vsnip#available(1)  ? "<Plug>(vsnip-expand-or-jump)" : "<C-l>"
smap <expr> <C-k> vsnip#available(1)  ? "<Plug>(vsnip-expand-or-jump)" : "<C-l>"

" Jump forward or backward
imap <expr> <C-j> vsnip#jumpable(1)   ? "<Plug>(vsnip-jump-next)"      : "<Tab>"
smap <expr> <C-j> vsnip#jumpable(1)   ? "<Plug>(vsnip-jump-next)"      : "<Tab>"
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

local function find_compile_commands_json()
    local current_dir = vim.fn.getcwd();
    local cmake_file = current_dir .. "/CMakeLists.txt";
    local compile_commands = current_dir .. "/build";

    if vim.fn.filereadable(cmake_file) ~= 1 then
        return compile_commands;
    end

    while current_dir ~= "" do
        local build_dir = current_dir .. "/build"
        local potential_path = vim.fn.glob(build_dir .. "/**/compile_commands.json", false, true);

        if #potential_path > 0 then
            compile_commands = vim.fn.fnamemodify(potential_path[1], ":h");
            break
        end

        -- Move to the parent directory
        current_dir = vim.fn.fnamemodify(current_dir, ":h");
    end

    return compile_commands;
end

local capabilities = require("ddc_source_lsp").make_client_capabilities();
capabilities.textDocument.completion.completionItem.snippetSupport = true;
local path_helper = require("helpers.path_helper");

--- The current buffer
local current_buffer = nil;

local local_map = function(mode, keys, func, desc)
    vim.keymap.set(mode, keys, func, { buffer = current_buffer, desc = desc });
end

local function go_to_next()
    vim.diagnostic.jump({ count = 1, float = true });
end

local function go_to_prev()
    vim.diagnostic.jump({ count = -1, float = true });
end

local function common_keybindings()
    vim.diagnostic.config({ virtual_text = false });
    local_map("n", "<Leader>ti", toggle_inlay_hint, "Toggle inlay hints");
    local_map("n", "<Leader>ra", vim.lsp.buf.code_action, "Run code actions");
    local_map("n", "<Leader>ga", vim.lsp.buf.declaration, "Goto declaration");
    local_map("n", "<Leader>nm", vim.lsp.buf.rename, "Rename symbol");
    local_map("n", "<Leader>cf", vim.lsp.buf.format, "Run code formatting");
    local_map("n", "<Leader>pd", vim.lsp.buf.hover, "Preview info above cursor");
    vim.keymap.set("n", ".", go_to_next, { noremap = true, silent = true });
    vim.keymap.set("n", ",", go_to_prev, { noremap = true, silent = true });
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

vim.lsp.config("powershell_es", {
    bundle_path = path_helper.expand_tilde("~/sources/language-servers/powershell"),
    on_attach = function(_, bufnr)
        current_buffer = bufnr;
        common_keybindings();
        configurable_functionality(
            vim.lsp.buf.definition,
            vim.lsp.buf.type_definition,
            vim.lsp.buf.references,
            vim.lsp.buf.implementation);
    end
});
vim.lsp.enable("powershell_es");

-- C#
vim.lsp.config("omnisharp", {
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
    end,
});
vim.lsp.enable("omnisharp");

-- Shader Slang
vim.lsp.config("slangd", {
    capabilities = capabilities,
    filetypes = { "slang", "shaderslang", "hlsl" },
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
        slang = {
            predefinedMacros = { "MY_VALUE_MACRO=1" },
            inlayHints = {
                deducedTypes = true,
                parameterNames = true,
            },
            format = {
                clangFormatLocation = "clang-format"
            }
        }
    },
});
vim.lsp.enable("slangd");

-- Lua
vim.lsp.config("lua_ls", {
    capabilities = capabilities,
    cmd = { "lua-language-server" },
    on_init = function(client)
        if client.workspace_folders then
            local path = client.workspace_folders[1].name
            if
                path ~= vim.fn.stdpath('config')
                and (vim.uv.fs_stat(path .. '/.luarc.json') or vim.uv.fs_stat(path .. '/.luarc.jsonc'))
            then
                return
            end
        end

        client.config.settings.Lua = vim.tbl_deep_extend('force', client.config.settings.Lua, {
            runtime = {
                -- Tell the language server which version of Lua you're using (most
                -- likely LuaJIT in the case of Neovim)
                version = 'LuaJIT',
                -- Tell the language server how to find Lua modules same way as Neovim
                -- (see `:h lua-module-load`)
                path = {
                    'lua/?.lua',
                    'lua/?/init.lua',
                },
            },
            -- Make the server aware of Neovim runtime files
            workspace = {
                checkThirdParty = false,
                library = {
                    vim.env.VIMRUNTIME
                    -- Depending on the usage, you might want to add additional paths
                    -- here.
                    -- '${3rd}/luv/library'
                    -- '${3rd}/busted/library'
                }
                -- Or pull in all of 'runtimepath'.
                -- NOTE: this is a lot slower and will cause issues when working on
                -- your own configuration.
                -- See https://github.com/neovim/nvim-lspconfig/issues/3189
                -- library = {
                --   vim.api.nvim_get_runtime_file('', true),
                -- }
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
vim.lsp.enable("lua_ls");

-- Clangd
vim.lsp.config("clangd", {
    capabilities = capabilities,
    cmd = { "clangd", "--inlay-hints=true", "--compile-commands-dir=" .. find_compile_commands_json() },
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
        vim.lsp.inlay_hint.enable(true);
    end,
});
vim.lsp.enable("clangd");

-- Rust Analyzer
vim.lsp.config("rust_analyzer", {
    capabilities = capabilities,
    cmd = { "rust-analyzer" },
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
        vim.lsp.inlay_hint.enable(true);
    end,
    settings = {
        ["rust-analyzer"] = {
            diagnostics = true
        }
    }
});
vim.lsp.enable("rust_analyzer");

-- Neocmake
vim.lsp.config("neocmake", {
    capabilities = capabilities,
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
        vim.lsp.inlay_hint.enable(true);
    end,
});
vim.lsp.enable("neocmake");

---------
-- DDC --
---------
local patch_ddc_global = vim.fn["ddc#custom#patch_global"];
patch_ddc_global({
    ui = "native",
    sources = { "lsp", "vsnip" },
    filterParams = {
        matcher_fuzzy = {
            splitWord = "word"
        },
        converter_fuzzy = {
            hlGroup = "SpellBad"
        }
    },
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
            enableResolveItem = false,
            isVolatile = true,
            enableAdditionalTextEdit = true,
            snippetEngine = vim.fn["denops#callback#register"](function(body)
                return vim.fn["vsnip#anonymous"](body)
            end),
        },
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
