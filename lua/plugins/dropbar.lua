return {
    "Bekaboo/dropbar.nvim",
    -- optional, but required for fuzzy finder support
    event = "VeryLazy",
    -- enabled =false,
    dependencies = {
        "nvim-telescope/telescope-fzf-native.nvim",
        build = "make",
    },
    opts = {
        bar = {
            sources = function(buf, _)
                local sources = require("dropbar.sources")
                local utils = require('dropbar.utils')
                if vim.bo[buf].ft == "markdown" then
                    return {
                        sources.path,
                        sources.markdown,
                    }
                end
                if vim.bo[buf].buftype == "terminal" then
                    return {
                        sources.terminal,
                    }
                end
                return {
                    sources.path,
                    utils.source.fallback({
                        sources.lsp,
                        -- sources.treesitter,
                    }),
                }
            end,
        },
        menu = {
            scrollbar = {
                enable = true,
                background = true,
            },
            win_configs = {
                border = "rounded",
            },
            hover = false,
        },
    },
    config = function(_, opts)
        require("dropbar").setup(opts)
        local dropbar_api = require("dropbar.api")
        vim.keymap.set("n", "<Leader>;", dropbar_api.pick, { desc = "Pick symbols in winbar" })
        vim.keymap.set("n", "[;", dropbar_api.goto_context_start, { desc = "Go to start of current context" })
        vim.keymap.set("n", "];", dropbar_api.select_next_context, { desc = "Select next context" })
        vim.ui.select = require("dropbar.utils.menu").select
        -- vim.api.nvim_set_hl(0, 'DropBarMenuHoverIcon', { bg = '#1f2335' })
        vim.api.nvim_set_hl(0, "DropBarMenuHoverIcon", {})
    end,
}
