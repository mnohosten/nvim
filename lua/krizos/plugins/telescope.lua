return {
    "nvim-telescope/telescope.nvim",
    branch = "master",
    dependencies = { "nvim-lua/plenary.nvim" },
    keys = {
        { "<leader>pf", function() require("telescope.builtin").find_files() end, desc = "Find files" },
        { "<C-p>", function()
            local ok = pcall(require("telescope.builtin").git_files)
            if not ok then
                require("telescope.builtin").find_files()
            end
        end, desc = "Git files (fallback to find_files)" },
        { "<leader>ps", function()
            require("telescope.builtin").grep_string({ search = vim.fn.input("Grep > ") })
        end, desc = "Grep string" },
        { "<leader>vh", function() require("telescope.builtin").help_tags() end, desc = "Help tags" },
        { "<leader>b", function() require("telescope.builtin").buffers() end, desc = "Switch buffer" },
    },
}
