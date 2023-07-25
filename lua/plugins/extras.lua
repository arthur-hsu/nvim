return{
    {
        'norcalli/nvim-colorizer.lua',
        event = 'VeryLazy',
        config = function ()
            require'colorizer'.setup()
        end
    },
    {
        'nvim-tree/nvim-web-devicons',
        lazy = true,
        --event = 'VeryLazy',
    },
    {
        'dstein64/vim-startuptime',
        event = 'VeryLazy',
    },
    {
        "nathom/filetype.nvim",
        --lazy=true
        event = 'VeryLazy',
    },
    {
        "sindrets/diffview.nvim",
        event = 'VeryLazy',
    },
    {
        'scrooloose/nerdcommenter',
        event = 'VeryLazy',
    },
    {
        'iamcco/markdown-preview.nvim',
        event = 'VeryLazy'
    }
}
