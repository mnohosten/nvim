require("lazy").setup({
    spec = {
        { import = "krizos.plugins" },
    },
    defaults = {
        lazy = false,
        version = false,
    },
    git = {
        -- Use shallow clones for better reliability on slow/unstable connections
        depth = 1,
        timeout = 120,
    },
    install = {
        colorscheme = { "rose-pine" },
    },
    checker = {
        enabled = true,
        notify = false,
    },
    performance = {
        rtp = {
            disabled_plugins = {
                "gzip",
                "tarPlugin",
                "tohtml",
                "tutor",
                "zipPlugin",
            },
        },
    },
})
