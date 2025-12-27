vim.g.mapleader = " "
vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)

-- Window navigation (using Alt key to avoid terminal conflicts)
vim.keymap.set("n", "<A-h>", "<C-w>h", { desc = "Move to left window" })
vim.keymap.set("n", "<A-j>", "<C-w>j", { desc = "Move to lower window" })
vim.keymap.set("n", "<A-k>", "<C-w>k", { desc = "Move to upper window" })
vim.keymap.set("n", "<A-l>", "<C-w>l", { desc = "Move to right window" })

