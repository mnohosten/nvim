return {
    -- Icons (required by other plugins)
    {
        "nvim-tree/nvim-web-devicons",
        lazy = true,
    },

    -- Statusline
    {
        "nvim-lualine/lualine.nvim",
        dependencies = { "nvim-tree/nvim-web-devicons" },
        opts = {
            options = {
                theme = "rose-pine",
                component_separators = { left = "", right = "" },
                section_separators = { left = "", right = "" },
            },
            sections = {
                lualine_a = { "mode" },
                lualine_b = { "branch", "diff", "diagnostics" },
                lualine_c = { { "filename", path = 1 } },
                lualine_x = { "encoding", "fileformat", "filetype" },
                lualine_y = { "progress" },
                lualine_z = { "location" },
            },
        },
    },

    -- Bufferline (tabs)
    {
        "akinsho/bufferline.nvim",
        version = "*",
        dependencies = { "nvim-tree/nvim-web-devicons" },
        opts = {
            options = {
                mode = "buffers",
                diagnostics = "nvim_lsp",
                diagnostics_indicator = function(count, level)
                    local icon = level:match("error") and " " or " "
                    return " " .. icon .. count
                end,
                offsets = {
                    { filetype = "neo-tree", text = "File Explorer", highlight = "Directory" },
                },
                show_buffer_close_icons = true,
                show_close_icon = false,
                separator_style = "slant",
            },
        },
        keys = {
            { "<A-Right>", "<cmd>BufferLineCycleNext<cr>", desc = "Next buffer" },
            { "<A-Left>", "<cmd>BufferLineCyclePrev<cr>", desc = "Previous buffer" },
            { "<leader>bc", "<cmd>bdelete<cr>", desc = "Close buffer" },
            { "<leader>bo", "<cmd>BufferLineCloseOthers<cr>", desc = "Close other buffers" },
            { "<leader>bp", "<cmd>BufferLineTogglePin<cr>", desc = "Pin buffer" },
        },
    },

    -- File Explorer (neo-tree)
    {
        "nvim-neo-tree/neo-tree.nvim",
        branch = "v3.x",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-tree/nvim-web-devicons",
            "MunifTanjim/nui.nvim",
        },
        cmd = "Neotree",
        keys = {
            { "<A-1>", "<cmd>Neotree toggle<cr>", desc = "Toggle file explorer" },
            { "<leader>e", "<cmd>Neotree focus<cr>", desc = "Focus file explorer" },
        },
        opts = {
            close_if_last_window = true,
            filesystem = {
                follow_current_file = { enabled = true },
                use_libuv_file_watcher = true,
                filtered_items = {
                    visible = true,
                    hide_dotfiles = false,
                    hide_gitignored = false,
                },
            },
            window = {
                width = 35,
                mappings = {
                    ["<space>"] = "none",
                },
            },
        },
    },

    -- Breadcrumbs
    {
        "SmiteshP/nvim-navic",
        lazy = true,
        opts = {
            lsp = { auto_attach = true },
        },
    },
    {
        "utilyre/barbecue.nvim",
        name = "barbecue",
        version = "*",
        dependencies = {
            "SmiteshP/nvim-navic",
            "nvim-tree/nvim-web-devicons",
        },
        opts = {},
    },

    -- Indent guides
    {
        "lukas-reineke/indent-blankline.nvim",
        main = "ibl",
        event = { "BufReadPre", "BufNewFile" },
        opts = {
            indent = { char = "│" },
            scope = { enabled = true },
        },
    },

    -- Trouble (diagnostics list)
    {
        "folke/trouble.nvim",
        cmd = { "TroubleToggle", "Trouble" },
        opts = {},
        keys = {
            { "<leader>xx", "<cmd>Trouble diagnostics toggle<cr>", desc = "Toggle Trouble" },
            { "<leader>xw", "<cmd>Trouble diagnostics toggle filter.buf=0<cr>", desc = "Document diagnostics" },
        },
    },
}
