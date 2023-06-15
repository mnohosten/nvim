local neotest = require("neotest")

vim.keymap.set("n", "<F10>", function()
    neotest.run.run()
end)
vim.keymap.set("n", "<F9>", function()
    neotest.output.open({
        auto_close = true,
        last_run = true,
        enter = false,
    })
end)
