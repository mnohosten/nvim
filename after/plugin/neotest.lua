local neotest = require("neotest")

vim.keymap.set("n", "<M-[>", function()
    neotest.run.run()
end)
vim.keymap.set("n", "<M-]>", function()
    neotest.output.open({
        auto_close = true,
        last_run = true,
        enter = false,
    })
end)
