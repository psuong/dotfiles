local language_servers = {};

----------------
-- File types --
----------------
vim.filetype.add({
    extension = {
        h = "c",
        ["scriban-cs"] = "cs",
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
            require("crates").setup({});
        end
    });
end
lazy_load_crates();

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

local buf_request_fn = vim.lsp.buf_request;
vim.lsp.buf_request = function(bufnr, method, params, handler)
    if method == "completionItem/resolve" then
        local supported = false;

        for _, client in ipairs(vim.lsp.get_clients({ bufnr = bufnr })) do
            local cp = client.server_capabilities.completionProvider;
            if cp and cp.resolveProvider then
                supported = true;
                break;
            end
        end

        if not supported then
            if handler then
                local client = vim.lsp.get_clients({ bufnr = bufnr })[1];
                handler(nil, params, { client_id = client and client.id, method = method });
            end
            return true;
        end
    end

    return buf_request_fn(bufnr, method, params, handler);
end

-----------
-- Blink --
-----------
local function is_blink_enabled()
    return vim.bo.filetype ~= "clap_input";
end
local cmp = require("blink.cmp");
cmp.build():pwait();
cmp.setup({
    enabled = is_blink_enabled,
    sources = {
        default = { "lsp", "path", "snippets", "buffer" },
    },
    snippets = { preset = "vsnip" },
    signature = {
        enabled = true,
        trigger = {
            enabled = true,
            show_on_trigger_character = false
        },
        window = {
            show_documentation = true,
            max_height = 10
        },
    },
    keymap = {
        preset = "none",
        ["<Tab>"] = {
            function(blink)
                -- Navigate forward in vsnip
                if vim.fn["vsnip#jumpable"](1) == 1 then
                    return "<Plug>(vsnip-jump-next)";
                end
                -- Navigate completion menu
                if blink.is_visible() then
                    return blink.select_next();
                end
                -- Show completion menu
                local col = vim.fn.col(".") - 1;
                if col > 0 then
                    local line = vim.fn.getline(".")
                    if line:sub(col, col):match("%s") then
                        return false;
                    end
                    return blink.show();
                end
                return false;
            end,
            "fallback",
        },
        ["<S-Tab>"] = {
            function(blink)
                -- Navigate backward in vsnip
                if vim.fn["vsnip#jumpable"](-1) == 1 then
                    return "<Plug>(vsnip-jump-prev)";
                end
                -- Navigate completion menu
                if blink.is_visible() then
                    return blink.select_prev();
                end
                return false;
            end,
            "fallback",
        },
        ["<CR>"] = {
            "accept",
            "fallback",
        },
        ["<C-j>"] = {  "scroll_signature_up" },
        ["<C-k>"] = { "scroll_signature_down" },
        -- toggle the documentation in the signature help window
        ["<C-h>"] = { "show_signature_documentation", "hide_signature_documentation" },
        -- default in all keymap presets
        ["<C-l>"] = { "show_signature", "hide_signature" },
    }
});

-- local capabilities = require("ddc_source_lsp").make_client_capabilities();
local capabilities = cmp.get_lsp_capabilities();
capabilities.textDocument.completion.completionItem.snippetSupport = true;

---------
-- LSP --
---------
local function toggle_inlay_hint()
    vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled());
end
local path_helper = require("helpers.path_helper");

--- The current buffer
local local_map = function(mode, keys, func, desc)
    local bufnr = vim.api.nvim_get_current_buf();
    vim.keymap.set(mode, keys, func, { buffer = bufnr, desc = desc });
end

local function go_to_next()
    vim.diagnostic.jump({
        count = 1,
        on_jump = function()
            vim.schedule(function()
                vim.diagnostic.open_float();
            end);
        end,
    });
end

local function go_to_prev()
    vim.diagnostic.jump({
        count = -1,
        on_jump = function()
            vim.schedule(function()
                vim.diagnostic.open_float();
            end);
        end,
    });
end

local function make_reference_params(bufnr)
    bufnr = bufnr or 0;
    local client = vim.lsp.get_clients({ bufnr = bufnr })[1];
    if not client then
        vim.notify("No LSP client attached to buffer", vim.log.levels.ERROR);
        return;
    end

    return vim.lsp.util.make_position_params(vim.api.nvim_get_current_win(), client.offset_encoding);
end

local function clap_refs()
    local params = make_reference_params(0);
    if not params then
        return;
    end
    vim.lsp.buf_request(0, "textDocument/references", params, function(err, result, ctx, config)
        if err then
            vim.notify("References error: " .. vim.inspect(err), vim.log.levels.ERROR);
            return
        end
        if not result or vim.tbl_isempty(result) then
            vim.notify("No references found", vim.log.levels.INFO);
            return
        end
        require("helpers.lsp_ui").clap_references_ui(err, result, ctx, config);
    end)
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
    end, "Show diagnostics float")
end

local function configurable_functionality(defs_callback, type_defs_callback, refs_callback, impl_callback)
    local_map("n", "<Leader>gd", defs_callback, "Go to definition");
    local_map("n", "<Leader>go", type_defs_callback, "Go to type definition");
    local_map("n", "<Leader>fu", refs_callback, "Find all references");
    local_map("n", "<Leader>fi", impl_callback, "Find all implementations");
end

vim.lsp.config("powershell_es", {
    bundle_path = path_helper.join("~", "sources", "tools", "powershell-lsp"),
    on_attach = function(_, _)
        common_keybindings();
        configurable_functionality(
            vim.lsp.buf.definition,
            vim.lsp.buf.type_definition,
            clap_refs,
            vim.lsp.buf.implementation);
    end
});
vim.lsp.enable("powershell_es");

-- C#
vim.lsp.config("roslyn", {
    on_attach = function()
        common_keybindings();
        configurable_functionality(
            vim.lsp.buf.definition,
            vim.lsp.buf.type_definition,
            vim.lsp.buf.references,
            -- clap_refs, -- TODO: Fix how vim clap gets the references
            vim.lsp.buf.implementation
        );
        local lsp_ui = require("helpers.lsp_ui");
        vim.ui.select = lsp_ui.on_select;
        vim.lsp.inlay_hint.enable(true);
    end,
    settings = {
        ["csharp|inlay_hints"] = {
            csharp_enable_inlay_hints_for_implicit_object_creation = true,
            csharp_enable_inlay_hints_for_implicit_variable_types = true,
            csharp_enable_inlay_hints_for_lambda_parameter_types = true,
            csharp_enable_inlay_hints_for_types = true,
            dotnet_enable_inlay_hints_for_indexer_parameters = true,
            dotnet_enable_inlay_hints_for_literal_parameters = true,
            dotnet_enable_inlay_hints_for_object_creation_parameters = true,
            dotnet_enable_inlay_hints_for_other_parameters = true,
            dotnet_enable_inlay_hints_for_parameters = true,
            dotnet_suppress_inlay_hints_for_parameters_that_match_argument_name = true,
            dotnet_suppress_inlay_hints_for_parameters_that_match_method_intent = false,
            dotnet_suppress_inlay_hints_for_parameters_that_differ_only_by_suffix = false
        },
        ["csharp|code_lens"] = {
            dotnet_enable_references_code_lens = true,
        },
    },
});
vim.lsp.enable("roslyn");

-- Shader Slang
vim.lsp.config("slangd", {
    capabilities = capabilities,
    filetypes = { "slang", "shaderslang", "hlsl" },
    on_attach = function(_, _)
        common_keybindings();
        configurable_functionality(
            vim.lsp.buf.definition,
            vim.lsp.buf.type_definition,
            clap_refs,
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
            local path = client.workspace_folders[1].name;
            if path ~= vim.fn.stdpath("config")
                and (
                    vim.uv.fs_stat(path .. "/.luarc.json")
                    or vim.uv.fs_stat(path .. "/.luarc.jsonc")
                )
            then
                return
            end
        end
    end,
    on_attach = function(_, _)
        common_keybindings();
        configurable_functionality(
            vim.lsp.buf.definition,
            vim.lsp.buf.type_definition,
            clap_refs,
            vim.lsp.buf.implementation
        );
        local lsp_ui = require("helpers.lsp_ui");
        vim.ui.select = lsp_ui.on_select;
        vim.lsp.handlers["textDocument/references"] = lsp_ui.clap_references_ui;
    end,
    settings = {
        Lua = {
            runtime = {
                version = "LuaJIT",
                path = {
                    "lua/?.lua",
                    "lua/?/init.lua",
                },
            },
            diagnostics = {
                globals = { "vim" },
            },
            workspace = {
                checkThirdParty = false,
                library = vim.api.nvim_get_runtime_file("", true),
            },
        },
    },
})
vim.lsp.enable("lua_ls");

local function find_compile_commands_json()
    local cwd = vim.loop.cwd();
    local path = cwd .. "/compile_commands.json";
    local stat = vim.loop.fs_stat(path);
    if stat and stat.type == "file" then
        return cwd;
    end
    return nil;
end

-- Clangd
vim.lsp.config("clangd", {
    capabilities = capabilities,
    cmd = (function()
        local cmd = { "clangd", "--inlay-hints=true", "--background-index=0" };
        local compile_dir = find_compile_commands_json();
        if compile_dir then
            table.insert(cmd, "--compile-commands-dir=" .. compile_dir);
        end
        return cmd;
    end)(),
    on_attach = function(client, bufnr)
        vim.lsp.completion.enable(true, client.id, bufnr);
        common_keybindings();
        configurable_functionality(
            vim.lsp.buf.definition,
            vim.lsp.buf.type_definition,
            clap_refs,
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
        common_keybindings();
        configurable_functionality(
            vim.lsp.buf.definition,
            vim.lsp.buf.type_definition,
            clap_refs,
            vim.lsp.buf.implementation);
        local lsp_ui = require("helpers.lsp_ui");
        vim.ui.select = lsp_ui.on_select;
        vim.lsp.handlers["textDocument/references"] = lsp_ui.clap_references_ui;

        vim.api.nvim_buf_set_keymap(bufnr, "n", "gr", "", {
            noremap = true,
            callback = function()
                local client = vim.lsp.get_clients({ bufnr = bufnr })[1];
                if not client then
                    vim.notify("No LSP client attached to buffer", vim.log.levels.ERROR);
                    return;
                end
                local params = vim.lsp.util.make_position_params(vim.api.nvim_get_current_win(), client.offset_encoding);
                vim.lsp.buf_request(0, "textDocument/references", params, lsp_ui.clap_references_ui);
            end,
        });

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
    on_attach = function(_, _)
        common_keybindings();
        configurable_functionality(
            vim.lsp.buf.definition,
            vim.lsp.buf.type_definition,
            clap_refs,
            vim.lsp.buf.implementation);
        local lsp_ui = require("helpers.lsp_ui");
        vim.ui.select = lsp_ui.on_select;
        vim.lsp.handlers["textDocument/references"] = lsp_ui.clap_references_ui;
        vim.lsp.inlay_hint.enable(true);
    end,
});
vim.lsp.enable("neocmake");

-- Markdown
vim.lsp.enable("marksman");

-- Toml
vim.lsp.enable("tombi");

return language_servers;
