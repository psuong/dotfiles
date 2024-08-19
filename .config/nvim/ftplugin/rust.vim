lua <<EOF
    ---------------------
    -- Package Manager --
    ---------------------
    require('crates').setup()

    --------------------------------
    -- Runs cargo check in the bg --
    --------------------------------
    require("bacon").setup({
        quickfix  = {
            enabled = true, -- true to populate the quickfix list with bacon errors and warnings
            event_trigger = true, -- triggers the QuickFixCmdPost event after populating the quickfix list
        }
    })

    local capabilities = require("ddc_source_lsp").make_client_capabilities
    require("lspconfig").denols.setup({
        capabilities = capabilities,
    })

    ------------------------
    -- Enable inlay hints --
    ------------------------
    vim.lsp.inlay_hint.enable(true)

    --------------------------
    -- Rustaceanvim Configs --
    --------------------------
    vim.g.rustaceanvim = {
        -- LSP configuration
        server = {
            on_attach = function(client, bufnr)
                -- you can also put keymaps in here
                local lsp_map = function(mode, keys, func, desc)
                  vim.keymap.set(mode, keys, func, { buffer = bufnr, desc = desc })
                end

                -- rust-lsp
                lsp_map("n", "K", function() vim.cmd.RustLsp({ "hover", "actions" }) end, "Rust hover docs")
                lsp_map("n", "J", function() vim.cmd.RustLsp("joinLines") end, "Rust join lines")
                lsp_map("n", "<Leader>ca", function() vim.cmd.RustLsp("codeAction") end, "Rust Code action")
                lsp_map("n", "<Leader>rue", function() vim.cmd.RustLsp("explainError") end, "Rust error explain")
                lsp_map("n", "<Leader>rud", function() vim.cmd.RustLsp("openDocs") end, "Rust docs")
                lsp_map("n", "<Leader>rum", function() vim.cmd.RustLsp("expandMacro") end, "Rust expand macro")

                -- copy from lsp_config
                lsp_map("n", "gd", vim.lsp.buf.definition, "Goto definition")
                lsp_map("n", "gD", vim.lsp.buf.declaration, "Goto declaration")
                lsp_map("n", "gI", vim.lsp.buf.implementation, "Goto implementation")
                lsp_map("n", "go", vim.lsp.buf.type_definition, "Goto type definition")
            end,
            default_settings = {
                -- rust-analyzer language server configuration
                ['rust-analyzer'] = { },
            },
        }
    }
EOF
