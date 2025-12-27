return {
    -- Fugitive (existing)
    {
        "tpope/vim-fugitive",
        cmd = { "Git", "Gdiff", "Gblame", "Gcommit", "Gpush", "Gpull" },
        keys = {
            { "<leader>gs", vim.cmd.Git, desc = "Git status" },
            { "<leader>gd", "<cmd>Gdiffsplit<cr>", desc = "Git diff" },
            { "<leader>gb", "<cmd>Git blame<cr>", desc = "Git blame" },
            { "<leader>gc", "<cmd>Git commit<cr>", desc = "Git commit" },
            { "<leader>gp", "<cmd>Git push<cr>", desc = "Git push" },
            { "<leader>gl", "<cmd>Git pull<cr>", desc = "Git pull" },
        },
    },

    -- Gitsigns (new - diff in gutter)
    {
        "lewis6991/gitsigns.nvim",
        event = { "BufReadPre", "BufNewFile" },
        opts = {
            signs = {
                add = { text = "+" },
                change = { text = "~" },
                delete = { text = "_" },
                topdelete = { text = "‾" },
                changedelete = { text = "~" },
            },
            current_line_blame = true,
            current_line_blame_opts = {
                virt_text = true,
                virt_text_pos = "eol",
                delay = 500,
            },
            on_attach = function(bufnr)
                local gs = package.loaded.gitsigns

                local function map(mode, l, r, opts)
                    opts = opts or {}
                    opts.buffer = bufnr
                    vim.keymap.set(mode, l, r, opts)
                end

                -- Navigation
                map("n", "]c", function()
                    if vim.wo.diff then return "]c" end
                    vim.schedule(function() gs.next_hunk() end)
                    return "<Ignore>"
                end, { expr = true, desc = "Next hunk" })

                map("n", "[c", function()
                    if vim.wo.diff then return "[c" end
                    vim.schedule(function() gs.prev_hunk() end)
                    return "<Ignore>"
                end, { expr = true, desc = "Previous hunk" })

                -- Actions
                map("n", "<leader>hs", gs.stage_hunk, { desc = "Stage hunk" })
                map("n", "<leader>hr", gs.reset_hunk, { desc = "Reset hunk" })
                map("v", "<leader>hs", function() gs.stage_hunk({ vim.fn.line("."), vim.fn.line("v") }) end)
                map("v", "<leader>hr", function() gs.reset_hunk({ vim.fn.line("."), vim.fn.line("v") }) end)
                map("n", "<leader>hS", gs.stage_buffer, { desc = "Stage buffer" })
                map("n", "<leader>hu", gs.undo_stage_hunk, { desc = "Undo stage hunk" })
                map("n", "<leader>hR", gs.reset_buffer, { desc = "Reset buffer" })
                map("n", "<leader>hp", gs.preview_hunk, { desc = "Preview hunk" })
                map("n", "<leader>hb", function() gs.blame_line({ full = true }) end, { desc = "Blame line" })
                map("n", "<leader>hd", gs.diffthis, { desc = "Diff this" })
                map("n", "<leader>hD", function() gs.diffthis("~") end, { desc = "Diff this ~" })
            end,
        },
    },
}
