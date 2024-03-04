return {
    {
        'norcalli/nvim-colorizer.lua',
        event = { "BufReadPost", "BufNewFile" },
        config = function ()
            require("colorizer").attach_to_buffer(0, {names = false, mode = "background", css = true})
        end
    },
    { 'nvim-tree/nvim-web-devicons', lazy = true, },
    { "nathom/filetype.nvim", event = "VimEnter", },
    { 'lithammer/nvim-pylance', lazy=true, enabled = false, },
    { 'dstein64/vim-startuptime', event="VimEnter", enabled = false, },
    {
        "keaising/im-select.nvim",
        config = function()
            require("im_select").setup({})
        end,
    },
    {
        "folke/edgy.nvim",
        event = "VeryLazy",
        enabled = true,
        opts = {
            -- Refer to my configuration here https://github.com/jellydn/lazy-nvim-ide/blob/main/lua/plugins/extras/edgy.lua
            right = {
                {
                    title = "CopilotChat.nvim", -- Title of the window
                    ft = "copilot-chat", -- This is custom file type from CopilotChat.nvim
                    size = { width = 0.4 }, -- Width of the window
                },
            },
        },
    }
}
