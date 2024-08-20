lua <<EOF
    ---------------------
    -- Package Manager --
    ---------------------
    require('crates').setup()

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
                local local_map = function(mode, keys, func, desc)
                  vim.keymap.set(mode, keys, func, { buffer = bufnr, desc = desc })
                end

                -- rust-lsp
                local_map("n", "<Leader>pd", function() vim.cmd.RustLsp({ "hover", "actions" }) end, "Rust hover docs")
                local_map("n", "J", function() vim.cmd.RustLsp("joinLines") end, "Rust join lines")
                local_map("n", "<Leader>ca", function() vim.cmd.RustLsp("codeAction") end, "Rust Code action")
                local_map("n", "<Leader>rue", function() vim.cmd.RustLsp("explainError") end, "Rust error explain")
                local_map("n", "<Leader>rud", function() vim.cmd.RustLsp("openDocs") end, "Rust docs")
                local_map("n", "<Leader>rum", function() vim.cmd.RustLsp("expandMacro") end, "Rust expand macro")

                -- copy from lsp_config
                local_map("n", "<Leader>ra", vim.lsp.buf.code_action, "Run code actions")
                local_map("n", "<Leader>gd", vim.lsp.buf.definition, "Goto definition")
                local_map("n", "<Leader>ga", vim.lsp.buf.declaration, "Goto declaration")
                local_map("n", "<Leader>gi", vim.lsp.buf.implementation, "Goto implementation")
                local_map("n", "<Leader>go", vim.lsp.buf.type_definition, "Goto type definition")
                local_map("n", "<Leader>nm", vim.lsp.buf.rename, "Rename symbol")
                local_map("n", "[[", vim.diagnostic.goto_prev, "Previous diagnostic")
                local_map("n", "]]", vim.diagnostic.goto_next, "Previous diagnostic")
            end,
            default_settings = {
                -- rust-analyzer language server configuration
                ['rust-analyzer'] = { },
            },
        }
    }
EOF

" Map in plain old vim
nmap <silent> <buffer> <Leader>cf :RustFmt<CR>

" Disable ALE for Rust cause we're using lsp
let g:ale_disable_lsp = 1
