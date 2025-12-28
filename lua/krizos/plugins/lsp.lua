return {
    -- LSP Zero
    {
        "VonHeikemen/lsp-zero.nvim",
        branch = "v3.x",
        lazy = true,
        config = false,
        init = function()
            vim.g.lsp_zero_extend_cmp = 0
            vim.g.lsp_zero_extend_lspconfig = 0
        end,
    },

    -- Mason
    {
        "williamboman/mason.nvim",
        lazy = false,
        config = true,
    },

    -- LSP
    {
        "neovim/nvim-lspconfig",
        cmd = { "LspInfo", "LspInstall", "LspStart" },
        event = { "BufReadPre", "BufNewFile" },
        dependencies = {
            "hrsh7th/cmp-nvim-lsp",
            "williamboman/mason-lspconfig.nvim",
        },
        config = function()
            local lsp_zero = require("lsp-zero")

            lsp_zero.on_attach(function(client, bufnr)
                local opts = { buffer = bufnr, remap = false }
                lsp_zero.default_keymaps({ buffer = bufnr })

                -- Original keymaps (preserved)
                vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end, opts)
                vim.keymap.set("n", "K", function() vim.lsp.buf.hover() end, opts)
                vim.keymap.set("n", "<leader>vws", function() vim.lsp.buf.workspace_symbol() end, opts)
                vim.keymap.set("n", "<leader>vd", function() vim.diagnostic.open_float() end, opts)
                vim.keymap.set("n", "[d", function() vim.diagnostic.goto_prev() end, opts)
                vim.keymap.set("n", "]d", function() vim.diagnostic.goto_next() end, opts)
                vim.keymap.set("n", "<leader>vca", function() vim.lsp.buf.code_action() end, opts)
                vim.keymap.set("n", "<leader>vrr", function() vim.lsp.buf.references() end, opts)
                vim.keymap.set("n", "<leader>vrn", function() vim.lsp.buf.rename() end, opts)
                vim.keymap.set("i", "<C-h>", function() vim.lsp.buf.signature_help() end, opts)

                -- IntelliJ-like keymaps (new)
                vim.keymap.set("n", "gD", function() vim.lsp.buf.declaration() end, opts)
                vim.keymap.set("n", "gi", function() vim.lsp.buf.implementation() end, opts)
                vim.keymap.set("n", "gr", function() vim.lsp.buf.references() end, opts)
                vim.keymap.set("n", "<C-k>", function() vim.lsp.buf.signature_help() end, opts)
                vim.keymap.set("n", "<leader>rn", function() vim.lsp.buf.rename() end, opts)
                vim.keymap.set("n", "<F6>", function() vim.lsp.buf.rename() end, opts)
                vim.keymap.set({ "n", "v" }, "<leader>ca", function() vim.lsp.buf.code_action() end, opts)
                vim.keymap.set({ "n", "v" }, "<A-CR>", function() vim.lsp.buf.code_action() end, opts)
            end)

            require("mason-lspconfig").setup({
                -- Note: lua_ls, rust_analyzer, gopls removed - not available on FreeBSD via Mason
                -- Install manually: pkg install go123 rust-analyzer, lua_ls build from source
                ensure_installed = { "ts_ls", "pyright", "phpactor" },
                handlers = {
                    lsp_zero.default_setup,

                    -- Lua
                    lua_ls = function()
                        local lua_opts = lsp_zero.nvim_lua_ls()
                        require("lspconfig").lua_ls.setup(lua_opts)
                    end,

                    -- Python (Pyright)
                    pyright = function()
                        require("lspconfig").pyright.setup({
                            settings = {
                                python = {
                                    analysis = {
                                        typeCheckingMode = "basic",
                                        autoImportCompletions = true,
                                    },
                                },
                            },
                        })
                    end,

                },
            })

            -- Setup rust-analyzer manually if installed system-wide (FreeBSD: pkg install rust-analyzer)
            if vim.fn.executable("rust-analyzer") == 1 then
                vim.lsp.config("rust_analyzer", {
                    cmd = { "rust-analyzer" },
                    root_markers = { "Cargo.toml", "rust-project.json" },
                })
                vim.lsp.enable("rust_analyzer")
            end

            -- Setup lua_ls manually if installed system-wide (FreeBSD: build from source)
            if vim.fn.executable("lua-language-server") == 1 then
                vim.lsp.config("lua_ls", {
                    cmd = { "lua-language-server" },
                    root_markers = { ".luarc.json", ".luarc.jsonc", ".luacheckrc", ".stylua.toml", "stylua.toml", "selene.toml", "selene.yml", ".git" },
                    settings = {
                        Lua = {
                            runtime = { version = "LuaJIT" },
                            diagnostics = { globals = { "vim" } },
                            workspace = {
                                library = vim.api.nvim_get_runtime_file("", true),
                                checkThirdParty = false,
                            },
                            telemetry = { enable = false },
                        },
                    },
                })
                vim.lsp.enable("lua_ls")
            end

            -- Setup gopls manually if installed system-wide (FreeBSD: pkg install go123 && go install golang.org/x/tools/gopls@latest)
            if vim.fn.executable("gopls") == 1 then
                vim.lsp.config("gopls", {
                    cmd = { "gopls" },
                    root_markers = { "go.mod", "go.work", ".git" },
                    settings = {
                        gopls = {
                            analyses = { unusedparams = true },
                            staticcheck = true,
                            gofumpt = true,
                        },
                    },
                })
                vim.lsp.enable("gopls")
            end

            -- Diagnostic configuration
            vim.diagnostic.config({
                virtual_text = true,
                signs = true,
                update_in_insert = false,
                underline = true,
                severity_sort = true,
                float = {
                    focusable = false,
                    style = "minimal",
                    border = "rounded",
                    source = "always",
                    header = "",
                    prefix = "",
                },
            })

            -- Custom sign icons
            vim.fn.sign_define("DiagnosticSignError", { text = "E", texthl = "DiagnosticSignError" })
            vim.fn.sign_define("DiagnosticSignWarn", { text = "W", texthl = "DiagnosticSignWarn" })
            vim.fn.sign_define("DiagnosticSignInfo", { text = "I", texthl = "DiagnosticSignInfo" })
            vim.fn.sign_define("DiagnosticSignHint", { text = "H", texthl = "DiagnosticSignHint" })
        end,
    },

    -- Copilot (AI completion with inline ghost text)
    {
        "zbirenbaum/copilot.lua",
        cmd = "Copilot",
        event = "InsertEnter",
        config = function()
            require("copilot").setup({
                panel = { enabled = false },
                suggestion = {
                    enabled = true,
                    auto_trigger = true,
                    debounce = 75,
                    keymap = {
                        accept = "<Tab>",
                        accept_word = "<M-w>",
                        accept_line = "<M-l>",
                        next = "<M-]>",
                        prev = "<M-[>",
                        dismiss = "<C-]>",
                    },
                },
                filetypes = {
                    yaml = true,
                    markdown = true,
                    help = false,
                    gitcommit = true,
                    gitrebase = false,
                    ["."] = false,
                },
            })
        end,
    },

    -- Autocompletion
    {
        "hrsh7th/nvim-cmp",
        event = "InsertEnter",
        dependencies = {
            "hrsh7th/cmp-buffer",
            "hrsh7th/cmp-path",
            "hrsh7th/cmp-nvim-lsp",
            "hrsh7th/cmp-nvim-lua",
            "saadparwaiz1/cmp_luasnip",
            "L3MON4D3/LuaSnip",
            "rafamadriz/friendly-snippets",
        },
        config = function()
            local cmp = require("cmp")
            local cmp_select = { behavior = cmp.SelectBehavior.Select }

            -- Load friendly snippets
            require("luasnip.loaders.from_vscode").lazy_load()

            -- Kind icons for completion menu
            local kind_icons = {
                Copilot = "",
                Text = "",
                Method = "",
                Function = "",
                Constructor = "",
                Field = "",
                Variable = "",
                Class = "",
                Interface = "",
                Module = "",
                Property = "",
                Unit = "",
                Value = "",
                Enum = "",
                Keyword = "",
                Snippet = "",
                Color = "",
                File = "",
                Reference = "",
                Folder = "",
                EnumMember = "",
                Constant = "",
                Struct = "",
                Event = "",
                Operator = "",
                TypeParameter = "",
            }

            cmp.setup({
                snippet = {
                    expand = function(args)
                        require("luasnip").lsp_expand(args.body)
                    end,
                },
                sources = {
                    { name = "nvim_lsp" },
                    { name = "nvim_lua" },
                    { name = "path" },
                    { name = "luasnip", keyword_length = 2 },
                    { name = "buffer", keyword_length = 3 },
                },
                mapping = cmp.mapping.preset.insert({
                    ["<C-p>"] = cmp.mapping.select_prev_item(cmp_select),
                    ["<C-n>"] = cmp.mapping.select_next_item(cmp_select),
                    ["<C-y>"] = cmp.mapping.confirm({ select = true }),
                    ["<C-Space>"] = cmp.mapping.complete(),
                }),
                formatting = {
                    format = function(entry, vim_item)
                        vim_item.kind = string.format("%s %s", kind_icons[vim_item.kind] or "", vim_item.kind)
                        vim_item.menu = ({
                            nvim_lsp = "[LSP]",
                            nvim_lua = "[Lua]",
                            luasnip = "[Snip]",
                            buffer = "[Buf]",
                            path = "[Path]",
                        })[entry.source.name]
                        return vim_item
                    end,
                },
                window = {
                    completion = cmp.config.window.bordered(),
                    documentation = cmp.config.window.bordered(),
                },
            })
        end,
    },
}
