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
    }
}
