return {
    -- Undotree (existing)
    {
        "mbbill/undotree",
        keys = {
            { "<leader>u", vim.cmd.UndotreeToggle, desc = "Toggle undotree" },
        },
    },

    -- Zen Mode (existing)
    {
        "folke/zen-mode.nvim",
        keys = {
            {
                "<leader>zz",
                function()
                    require("zen-mode").setup({
                        window = {
                            width = 90,
                            options = {},
                        },
                    })
                    require("zen-mode").toggle()
                    vim.wo.wrap = false
                    vim.wo.number = true
                    vim.wo.rnu = true
                    ColorMyPencils()
                end,
                desc = "Zen mode (with numbers)",
            },
            {
                "<leader>zZ",
                function()
                    require("zen-mode").setup({
                        window = {
                            width = 80,
                            options = {},
                        },
                    })
                    require("zen-mode").toggle()
                    vim.wo.wrap = false
                    vim.wo.number = false
                    vim.wo.rnu = false
                    vim.opt.colorcolumn = "0"
                    ColorMyPencils()
                end,
                desc = "Zen mode (minimal)",
            },
        },
    },

    -- Cloak (existing - hide secrets)
    {
        "laytan/cloak.nvim",
        event = { "BufReadPre", "BufNewFile" },
        opts = {
            enabled = true,
            cloak_character = "*",
            highlight_group = "Comment",
            patterns = {
                {
                    file_pattern = {
                        ".env*",
                        "wrangler.toml",
                        ".dev.vars",
                    },
                    cloak_pattern = "=.+",
                },
            },
        },
    },

    -- Copilot (existing)
    {
        "github/copilot.vim",
        event = "InsertEnter",
    },

    -- Auto pairs (new)
    {
        "windwp/nvim-autopairs",
        event = "InsertEnter",
        opts = {
            check_ts = true,
            ts_config = {
                lua = { "string", "source" },
                javascript = { "string", "template_string" },
            },
        },
        config = function(_, opts)
            require("nvim-autopairs").setup(opts)
            -- Integration with nvim-cmp
            local cmp_autopairs = require("nvim-autopairs.completion.cmp")
            local cmp = require("cmp")
            cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
        end,
    },

    -- Which-key (new - keybinding hints)
    {
        "folke/which-key.nvim",
        event = "VeryLazy",
        opts = {
            plugins = {
                marks = true,
                registers = true,
                spelling = { enabled = true, suggestions = 20 },
            },
        },
        config = function(_, opts)
            local wk = require("which-key")
            wk.setup(opts)

            wk.add({
                { "<leader>b", group = "Buffer" },
                { "<leader>c", group = "Code" },
                { "<leader>d", group = "Debug" },
                { "<leader>g", group = "Git" },
                { "<leader>h", group = "Git Hunks" },
                { "<leader>p", group = "Project" },
                { "<leader>s", group = "Search" },
                { "<leader>t", group = "Terminal/Test" },
                { "<leader>v", group = "LSP" },
                { "<leader>x", group = "Trouble" },
                { "<leader>z", group = "Zen Mode" },
            })
        end,
    },

    -- Toggleterm (new - terminal management)
    {
        "akinsho/toggleterm.nvim",
        version = "*",
        keys = {
            { "<A-F12>", "<cmd>ToggleTerm<cr>", desc = "Toggle terminal" },
            { "<leader>tt", "<cmd>ToggleTerm<cr>", desc = "Toggle terminal" },
            { "<leader>tf", "<cmd>ToggleTerm direction=float<cr>", desc = "Float terminal" },
            { "<leader>th", "<cmd>ToggleTerm direction=horizontal<cr>", desc = "Horizontal terminal" },
            { "<leader>tv", "<cmd>ToggleTerm direction=vertical<cr>", desc = "Vertical terminal" },
        },
        opts = {
            size = function(term)
                if term.direction == "horizontal" then
                    return 15
                elseif term.direction == "vertical" then
                    return vim.o.columns * 0.4
                end
            end,
            open_mapping = [[<A-F12>]],
            hide_numbers = true,
            shade_terminals = true,
            shading_factor = 2,
            start_in_insert = true,
            insert_mappings = true,
            terminal_mappings = true,
            persist_size = true,
            direction = "horizontal",
            close_on_exit = true,
            shell = vim.o.shell,
            float_opts = {
                border = "curved",
                winblend = 0,
            },
        },
    },

    -- Refactoring (existing)
    { "theprimeagen/refactoring.nvim" },

    -- Cellular automaton (fun/existing)
    {
        "eandrju/cellular-automaton.nvim",
        cmd = "CellularAutomaton",
    },

    -- Codicons (existing)
    { "mortepau/codicons.nvim" },
}
