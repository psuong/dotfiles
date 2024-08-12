lua <<EOF
    require('crates').setup()
EOF

lua <<EOF
    require("bacon").setup({
        quickfix  = {
            enabled = true, -- true to populate the quickfix list with bacon errors and warnings
            event_trigger = true, -- triggers the QuickFixCmdPost event after populating the quickfix list
        }
    })
EOF