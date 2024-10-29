return {
    {
        'norcalli/nvim-colorizer.lua',
        event = { "BufReadPost", "BufNewFile" },
        config = function ()
            require("colorizer").attach_to_buffer(0, {names = false, mode = "background", css = true})
        end
    },
    { 'nvim-tree/nvim-web-devicons', lazy = true, },
    { 'echasnovski/mini.nvim', lazy=true },
    { "nathom/filetype.nvim", event = "VimEnter", },
    { 'lithammer/nvim-pylance', lazy=true, enabled = false, },
    { 'dstein64/vim-startuptime', event="VimEnter", enabled = false, },
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
        -- event = "VeryLazy",
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
        dependencies = {
            "akinsho/toggleterm.nvim"
        },
        ft = { "csv" },
        config = true,
        opts = { --[[ Place your opts here ]] }
    }
}
