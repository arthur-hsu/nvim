return {
    {
        'norcalli/nvim-colorizer.lua',
        -- event = { "BufReadPost", "BufNewFile" },
        event = "VeryLazy",
        config = function()
            require("colorizer").attach_to_buffer(0, { names = false, mode = "background", css = true })
        end
    },
    { 'nvim-tree/nvim-web-devicons' },
    { 'echasnovski/mini.nvim' },
    {
        "ibhagwan/fzf-lua",
        -- optional for icon support
        event = "VeryLazy",
        dependencies = { "nvim-tree/nvim-web-devicons" },
        config = function()
            -- calling `setup` is optional for customization
            require("fzf-lua").setup({})
        end
    },
    {
        'hat0uma/csvview.nvim',
        ft = { "csv" },
        config = function()
            require('csvview').setup({
                view = {
                    spacing      = 0,
                    display_mode = "border",
                }
            })
        end
    },
    {
        "theKnightsOfRohan/csvlens.nvim",
        ft = { "csv" },
        dependencies = {
            "akinsho/toggleterm.nvim"
        },
        config = true,
        opts = { --[[ Place your opts here ]] }
    },
    {
        'xorid/asciitree.nvim',
        lazy = true,
        cmd = { 'AsciiTree', 'AsciiTreeUndo' },
        opt = {
            depth = 2,
            delimiter = "#",
            symbols = {
                child  = "├",
                last   = "└",
                parent = "│",
                dash   = "─",
                blank  = " ",
            },
        }
    }
}
