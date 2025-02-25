return {
    {
        "utilyre/barbecue.nvim",
        name = "barbecue",
        version = "*",
        event = "VeryLazy",
        enabled = false,
        dependencies = {
            "SmiteshP/nvim-navic",
            "nvim-tree/nvim-web-devicons", -- optional dependency
        },
        opts = {
            -- configurations go here
        },
    },
    {
        'Bekaboo/dropbar.nvim',
        -- optional, but required for fuzzy finder support
        event = "VeryLazy",
        dependencies = {
            'nvim-telescope/telescope-fzf-native.nvim',
            build = 'make'
        },
        opts = {
            menu = {
                scrollbar = {
                    enable = true,
                    background = false,
                },
                win_configs = {
                    border = "rounded"
                }
            }
        },
        config = function(_, opts)
            require('dropbar').setup(opts)
            local dropbar_api = require('dropbar.api')
            vim.keymap.set('n', '<Leader>;', dropbar_api.pick, { desc = 'Pick symbols in winbar' })
            vim.keymap.set('n', '[;', dropbar_api.goto_context_start, { desc = 'Go to start of current context' })
            vim.keymap.set('n', '];', dropbar_api.select_next_context, { desc = 'Select next context' })
            vim.ui.select = require('dropbar.utils.menu').select
            -- vim.api.nvim_set_hl(0, 'DropBarMenuHoverIcon', { bg = '#1f2335' })
            vim.api.nvim_set_hl(0, 'DropBarMenuHoverIcon', {})
        end
    }
}
