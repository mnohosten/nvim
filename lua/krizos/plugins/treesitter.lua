return {
    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
        event = { "BufReadPre", "BufNewFile" },
        config = function()
            -- New nvim-treesitter API - install parsers
            local parsers = {
                "vimdoc", "javascript", "typescript", "tsx", "c", "lua", "rust", "php",
                "python", "go", "html", "css", "json", "yaml", "dockerfile", "sql", "bash", "markdown"
            }

            -- Install missing parsers on startup
            vim.api.nvim_create_autocmd("VimEnter", {
                callback = function()
                    local installed = require("nvim-treesitter.config").get_installed()
                    local to_install = {}
                    for _, parser in ipairs(parsers) do
                        if not vim.tbl_contains(installed, parser) then
                            table.insert(to_install, parser)
                        end
                    end
                    if #to_install > 0 then
                        require("nvim-treesitter").install(to_install)
                    end
                end,
                once = true,
            })

            -- Enable treesitter highlighting (built-in Neovim feature)
            vim.api.nvim_create_autocmd("FileType", {
                pattern = "*",
                callback = function()
                    pcall(vim.treesitter.start)
                end,
            })
        end,
    },
    {
        "nvim-treesitter/nvim-treesitter-context",
        event = { "BufReadPre", "BufNewFile" },
    },
}
