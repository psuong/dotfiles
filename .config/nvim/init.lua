if not vim.g.vscode then
    local wanted = {};
    local Plug = function(repo)
        local name = repo:match("/([^/]+)$")
        wanted[name] = true
        return "git@github.com:" .. repo .. ".git"
    end

    vim.pack.add({
        --------------------
        -- Editor Styling --
        --------------------
        Plug("ellisonleao/gruvbox.nvim"),
        Plug("echasnovski/mini.indentscope"),
        Plug("nvim-tree/nvim-web-devicons"),
        Plug("TheLeoP/fern-renderer-web-devicons.nvim"),
        Plug("nvim-treesitter/nvim-treesitter"),

        ---------------
        -- Searchers --
        ---------------
        Plug("liuchengxu/vim-clap"),
        Plug("lambdalisue/vim-fern"),
        Plug("lambdalisue/vim-glyph-palette"),

        ------------------
        -- Autocomplete --
        ------------------
        Plug("neovim/nvim-lspconfig"),
        Plug("stevearc/aerial.nvim"),
        Plug("vim-denops/denops.vim"),
        Plug("vim-denops/denops-shared-server.vim"),
        Plug("Shougo/ddc.vim"),
        Plug("Shougo/ddc-ui-native"),
        Plug("Shougo/ddc-source-lsp"),
        Plug("tani/ddc-fuzzy"),
        Plug("rafamadriz/friendly-snippets"),
        Plug("hrsh7th/vim-vsnip"),
        Plug("uga-rosa/ddc-source-vsnip"),
        Plug("matsui54/denops-popup-preview.vim"),
        Plug("matsui54/denops-signature_help"),
        Plug("seblyng/roslyn.nvim"),
        -- Plug("psuong/omnisharp-extended-lsp.nvim"),
        Plug("kkoomen/vim-doge"),

        ----------------------
        -- Package managers --
        ----------------------
        Plug("saecki/crates.nvim"),

        --------------
        -- Previews --
        --------------
        Plug("iamcco/markdown-preview.nvim"),

        --------------
        -- Profiler --
        --------------
        Plug("dstein64/vim-startuptime"),
    });

    local function run_post_hooks()
        local hooks = {
            ["vim-clap"] = function()
                vim.cmd("Clap install-binary");
            end,
            ["vim-doge"] = function()
                vim.fn["doge#install"]();
            end,
            ["denops-shared-server"] = function()
                vim.cmd("call denops_shared_server#install()");
            end,
            ["nvim-treesitter"] = function()
                vim.cmd("TSUpdate");
            end,
            ["markdown-preview"] = function()
                vim.cmd("call mkdp#util#install()");
            end
        };

        for name, hook in pairs(hooks) do
            local ok, err = pcall(hook);
            if not ok then
                vim.notify(
                    ("Post hook for %s failed:\n%s"):format(name, err),
                    vim.log.levels.ERROR
                );
            end
        end
    end

    vim.api.nvim_create_user_command("PackPostInstall", function()
        run_post_hooks();
    end, {});

    vim.api.nvim_create_user_command("PackCheck", function(opts)
        vim.pack.update(opts.fargs, { preview = true, });
    end, { nargs = "*", });

    vim.api.nvim_create_user_command("PackUpdate", function(opts)
        vim.pack.update(opts.fargs, { force = opts.bang });
    end, { nargs = "*", bang = true, });

    vim.api.nvim_create_user_command("PackClean", function(opts)
        local unused = {};
        for _, plugin in ipairs(vim.pack.get()) do
            if not wanted[plugin.spec.name] then
                table.insert(unused, plugin.spec.name);
            end
        end
        if #unused == 0 then
            vim.notify("No unused packages", vim.log.levels.INFO);
            return
        end
        if not opts.bang then
            vim.notify(
                "Unused packages:\n  " .. table.concat(unused, "\n  ")
                .. "\n\nRun :PackClean! to remove them.",
                vim.log.levels.WARN
            );
            return
        end
        vim.pack.del(unused);
        vim.notify(
            "Removed " .. #unused .. " package(s):\n  "
            .. table.concat(unused, "\n  "),
            vim.log.levels.INFO
        );
    end, {
        bang = true,
    })

    require("configs.theme");
    require("configs.base_keybinds");
    require("configs.syntax");
    require("configs.language_servers");
    require("configs.terminal");
    require("configs.explorer");
    require("configs.neovide");
end
