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

    local capabilities = require("ddc_source_lsp").make_client_capabilities()
    require("lspconfig").denols.setup({
        capabilities = capabilities,
    })

    ------------------------
    -- Enable inlay hints --
    ------------------------
    vim.lsp.inlay_hint.enable(true)
EOF
