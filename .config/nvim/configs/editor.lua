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
vim.cmd("colorscheme gruvbox");

-- Define a highlight group for TODO comments
vim.cmd("highlight Todo cterm=bold gui=bold");

-- Create an autocmd to highlight TODO comments
vim.api.nvim_create_autocmd("Syntax", {
    pattern = "*",
    command = "match Todo /TODO/",
});

------------------
-- Indent Lines --
------------------
local indentscope = require("mini.indentscope");
indentscope.gen_animation.none();
indentscope.setup({
    draw = {
        delay = 0,
        animation = indentscope.gen_animation.none(),
        predicate = function() return true; end,
        priority = 2,
    },
    symbol = "│",
    filetypes = { "*" },
    -- Ignore netrw buffers
    hooks = {
        pre = function(bufnr)
            local filetype = vim.api.nvim_buf_get_option(bufnr, 'filetype')
            if filetype == "netrw" then
                -- Disable indentscope for netrw buffers
                vim.b.indentscope_disable = true
            end
        end,
    },
});

------------------------------------
-- Treesitter/Syntax Highlighting --
------------------------------------
vim.wo.foldmethod = "expr";
vim.wo.foldexpr = "v:lua.vim.treesitter.foldexpr()";
vim.o.foldlevelstart = 50;

-- Fold the function or block under the cursor
vim.api.nvim_set_keymap("n", "zz", "za", { noremap = true, silent = true });

require("nvim-treesitter.install").compilers = { "clang", "gcc" }
require("nvim-treesitter.configs").setup {
    -- A list of parser names, or "all"
    ensure_installed = {
        "c",
        "cpp",
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
    indent = {
        enable = true
    },
}

-----------------
-- Keybindings --
-----------------
vim.keymap.set("n", "j", "gj");
vim.keymap.set("n", "k", "gk");
vim.g.mapleader = ",";

vim.keymap.set("n", "[c", function()
    require("treesitter-context").go_to_context();
end, { silent = true });

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
local omnisharp_bin = path_helper.expand_tilde("~/sources/language-servers/omnisharp/OmniSharp.exe");
local lua_ls_bin = path_helper.expand_tilde("~/sources/language-servers/lua/bin/lua-language-server.exe");

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

local patch_ddc = vim.fn["ddc#custom#patch_global"];
patch_ddc({
    ui = "native",
    sources = { "lsp", "vsnip" },
    sourceOptions = {
        ["_"] = {
            matchers = { "matcher_fuzzy" },
            sorters = { "sorter_fuzzy" },
            converters = { "converter_fuzzy" },
        },
        lsp = {
            mark = "LSP",
            forceCompletionPattern = [[\.\w*|:\w*|->\w*]],
            maxItems = 20,
        },
        vsnip = {
            mark = "SNIP",
            maxItems = 5,
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

-------------
-- Keymaps --
-------------
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
vim.fn["signature_help#enable"]()

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
local function lazy_load_crates()
    vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
        pattern = "Cargo.toml",
        callback = function()
            require("crates").setup();
        end
    });
end
lazy_load_crates();

-- Remove undercurl
local function get_color(group, attr)
    local hl = vim.api.nvim_get_hl(0, { name = group, link = false })
    return hl and hl[attr] or "NONE"
end

local red = get_color("GruvboxRed", "fg");
local yellow = get_color("GruvboxYellow", "fg");
local gray = get_color("GruvboxGray", "fg");
local orange = get_color("GruvboxOrange", "fg");

vim.api.nvim_set_hl(0, "DiagnosticUnderlineError", { undercurl = false, underline = true, sp = red });
vim.api.nvim_set_hl(0, "DiagnosticUnderlineWarn", { undercurl = false, underline = true, sp = yellow });
vim.api.nvim_set_hl(0, "DiagnosticUnderlineHint", { undercurl = false, underline = true, sp = orange });
vim.api.nvim_set_hl(0, "DiagnosticUnderlineInfo", { undercurl = false, underline = true, sp = gray });

require("nvim-web-devicons").setup();
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
