return {
    {
        "mfussenegger/nvim-dap",
        dependencies = {
            "rcarriga/nvim-dap-ui",
            "nvim-neotest/nvim-nio",
            "theHamsta/nvim-dap-virtual-text",
            "williamboman/mason.nvim",
            "jay-babu/mason-nvim-dap.nvim",
            -- Language-specific plugins
            "mfussenegger/nvim-dap-python",
            "leoluz/nvim-dap-go",
        },
        keys = {
            -- IntelliJ-like keybindings
            { "<F5>", function() require("dap").continue() end, desc = "Debug: Start/Continue" },
            { "<F9>", function() require("dap").toggle_breakpoint() end, desc = "Debug: Toggle Breakpoint" },
            { "<F10>", function() require("dap").step_over() end, desc = "Debug: Step Over" },
            { "<F11>", function() require("dap").step_into() end, desc = "Debug: Step Into" },
            { "<S-F11>", function() require("dap").step_out() end, desc = "Debug: Step Out" },
            { "<F8>", function() require("dap").step_out() end, desc = "Debug: Step Out (alt)" },
            { "<leader>db", function() require("dap").toggle_breakpoint() end, desc = "Toggle Breakpoint" },
            { "<leader>dB", function() require("dap").set_breakpoint(vim.fn.input("Breakpoint condition: ")) end, desc = "Conditional Breakpoint" },
            { "<leader>dc", function() require("dap").continue() end, desc = "Continue" },
            { "<leader>di", function() require("dap").step_into() end, desc = "Step Into" },
            { "<leader>do", function() require("dap").step_over() end, desc = "Step Over" },
            { "<leader>dO", function() require("dap").step_out() end, desc = "Step Out" },
            { "<leader>dr", function() require("dap").repl.toggle() end, desc = "Toggle REPL" },
            { "<leader>dl", function() require("dap").run_last() end, desc = "Run Last" },
            { "<leader>dt", function() require("dap").terminate() end, desc = "Terminate" },
            { "<leader>du", function() require("dapui").toggle() end, desc = "Toggle DAP UI" },
        },
        config = function()
            local dap = require("dap")
            local dapui = require("dapui")

            require("mason-nvim-dap").setup({
                ensure_installed = { "php", "js", "python", "delve" },
                automatic_installation = true,
                handlers = {},
            })

            -- Virtual text for variables
            require("nvim-dap-virtual-text").setup({})

            -- DAP UI setup
            dapui.setup({
                icons = { expanded = "▾", collapsed = "▸", current_frame = "*" },
                mappings = {
                    expand = { "<CR>", "<2-LeftMouse>" },
                    open = "o",
                    remove = "d",
                    edit = "e",
                    repl = "r",
                    toggle = "t",
                },
                layouts = {
                    {
                        elements = {
                            { id = "scopes", size = 0.25 },
                            { id = "breakpoints", size = 0.25 },
                            { id = "stacks", size = 0.25 },
                            { id = "watches", size = 0.25 },
                        },
                        size = 40,
                        position = "left",
                    },
                    {
                        elements = {
                            { id = "repl", size = 0.5 },
                            { id = "console", size = 0.5 },
                        },
                        size = 10,
                        position = "bottom",
                    },
                },
            })

            -- Auto open/close DAP UI
            dap.listeners.after.event_initialized["dapui_config"] = function()
                dapui.open()
            end
            dap.listeners.before.event_terminated["dapui_config"] = function()
                dapui.close()
            end
            dap.listeners.before.event_exited["dapui_config"] = function()
                dapui.close()
            end

            -- PHP Debug Adapter
            dap.adapters.php = {
                type = "executable",
                command = "node",
                args = { vim.fn.stdpath("data") .. "/mason/packages/php-debug-adapter/extension/out/phpDebug.js" },
            }
            dap.configurations.php = {
                {
                    type = "php",
                    request = "launch",
                    name = "Listen for Xdebug",
                    port = 9003,
                    pathMappings = {
                        ["/var/www/html"] = "${workspaceFolder}",
                    },
                },
            }

            -- JavaScript/TypeScript Debug Adapter
            dap.adapters["pwa-node"] = {
                type = "server",
                host = "localhost",
                port = "${port}",
                executable = {
                    command = "node",
                    args = {
                        vim.fn.stdpath("data") .. "/mason/packages/js-debug-adapter/js-debug/src/dapDebugServer.js",
                        "${port}",
                    },
                },
            }
            dap.configurations.javascript = {
                {
                    type = "pwa-node",
                    request = "launch",
                    name = "Launch file",
                    program = "${file}",
                    cwd = "${workspaceFolder}",
                },
            }
            dap.configurations.typescript = dap.configurations.javascript

            -- Python (using nvim-dap-python)
            local ok_python, dap_python = pcall(require, "dap-python")
            if ok_python then
                local debugpy_path = vim.fn.stdpath("data") .. "/mason/packages/debugpy/venv/bin/python"
                if vim.fn.filereadable(debugpy_path) == 1 then
                    dap_python.setup(debugpy_path)
                end
            end

            -- Go (using nvim-dap-go)
            local ok_go, dap_go = pcall(require, "dap-go")
            if ok_go then
                dap_go.setup()
            end
        end,
    },
}
