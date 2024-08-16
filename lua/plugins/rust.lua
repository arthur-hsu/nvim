return {
    {
        'mrcjkb/rustaceanvim',
        ft = { 'rust' },
        dependencies = {
            -- "neovim/nvim-lspconfig",
            "nvim-lua/plenary.nvim",
            'mfussenegger/nvim-dap',
        },
        config = function ()
            vim.g.rustaceanvim = {
                tools = {
                    hover_actions = {
                        auto_focus = true,
                    },
                },
            }
        end
    }
}
