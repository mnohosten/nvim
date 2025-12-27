return {
    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
        event = { "BufReadPre", "BufNewFile" },
        config = function()
            -- Install parsers
            require("nvim-treesitter").install({
                "vimdoc", "javascript", "typescript", "tsx", "c", "lua", "rust", "php",
                "python", "go", "html", "css", "json", "yaml", "dockerfile", "sql", "bash", "markdown"
            })

            -- Enable treesitter highlighting for specific filetypes
            vim.api.nvim_create_autocmd("FileType", {
                pattern = {
                    "javascript", "typescript", "tsx", "c", "lua", "rust", "php", "vim", "help",
                    "python", "go", "html", "css", "json", "yaml", "dockerfile", "sql", "bash", "markdown"
                },
                callback = function()
                    vim.treesitter.start()
                end,
            })
        end,
    },
    {
        "nvim-treesitter/nvim-treesitter-context",
        event = { "BufReadPre", "BufNewFile" },
    },
}
