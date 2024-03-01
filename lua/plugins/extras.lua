return {
    {
        'https://github.com/norcalli/nvim-colorizer.lua',
        event = { "BufReadPost", "BufNewFile" },
        config = function ()
            require("colorizer").attach_to_buffer(0, {names = false, mode = "background", css = true})
        end
    },
    { 'https://github.com/nvim-tree/nvim-web-devicons', lazy = true, },
    { "https://github.com/nathom/filetype.nvim", event = "VimEnter", },
    { 'lithammer/nvim-pylance', lazy=true, enabled = false, },
    { 'https://github.com/dstein64/vim-startuptime', event="VimEnter", enabled = false, },
    {
        "https://github.com/vladdoster/remember.nvim",
        event = "VimEnter",
        enabled = false,
        config = function ()
            require("remember").setup({
                ignore_buftype = {
                    "TelescopePrompt",
                    "alpha",
                    "mason",
                    "lazy",
                    "DiffviewFileHistory",
                    "DiffviewFiles",
                    "Trouble",
                    "lspinfo"
                },
                open_folds = true,
                remember_dont_center = true
            })
        end
    }
}
