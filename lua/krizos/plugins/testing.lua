return {
    {
        "nvim-neotest/neotest",
        dependencies = {
            "nvim-neotest/nvim-nio",
            "nvim-lua/plenary.nvim",
            "nvim-treesitter/nvim-treesitter",
            "antoinemadec/FixCursorHold.nvim",
            -- Adapters
            "olimorris/neotest-phpunit",
            "nvim-neotest/neotest-python",
            "nvim-neotest/neotest-go",
            "nvim-neotest/neotest-jest",
        },
        keys = {
            -- Original keymaps (preserved)
            { "<M-[>", function() require("neotest").run.run() end, desc = "Run nearest test" },
            { "<M-]>", function()
                require("neotest").output.open({
                    auto_close = true,
                    last_run = true,
                    enter = false,
                })
            end, desc = "Show test output" },
            -- New keymaps
            { "<leader>tn", function() require("neotest").run.run() end, desc = "Run nearest test" },
            { "<leader>tf", function() require("neotest").run.run(vim.fn.expand("%")) end, desc = "Run file tests" },
            { "<leader>ts", function() require("neotest").run.run({ suite = true }) end, desc = "Run test suite" },
            { "<leader>tl", function() require("neotest").run.run_last() end, desc = "Run last test" },
            { "<leader>to", function() require("neotest").output.open({ enter = true }) end, desc = "Show test output" },
            { "<leader>tO", function() require("neotest").output_panel.toggle() end, desc = "Toggle output panel" },
            { "<leader>tS", function() require("neotest").summary.toggle() end, desc = "Toggle summary" },
            { "<leader>td", function() require("neotest").run.run({ strategy = "dap" }) end, desc = "Debug nearest test" },
        },
        config = function()
            require("neotest").setup({
                adapters = {
                    require("neotest-phpunit"),
                    require("neotest-python")({
                        dap = { justMyCode = false },
                    }),
                    require("neotest-go"),
                    require("neotest-jest")({
                        jestCommand = "npm test --",
                    }),
                },
                status = { virtual_text = true },
                output = { open_on_run = true },
            })
        end,
    },
}
