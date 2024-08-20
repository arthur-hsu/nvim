return {
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl",
    event = { "BufReadPost", "BufNewFile" },
    dependencies = {
        {
            'HiPhish/rainbow-delimiters.nvim',
            config = function()
                -- This module contains a number of default definitions
                -- require('rainbow-delimiters').setup({})
                local rainbow_delimiters = require('rainbow-delimiters')
                vim.g.rainbow_delimiters = {
                    strategy = {
                        [''] = rainbow_delimiters.strategy['global'],
                        vim = rainbow_delimiters.strategy['local'],
                    },
                    query = {
                        [''] = 'rainbow-delimiters',
                        lua = 'rainbow-blocks',
                    },
                }
            end,
        },
    },
    config= function()
        local highlight = {
            "RainbowViolet",
            "RainbowYellow",
            "RainbowBlue",
            "RainbowGreen",
            "RainbowRed",
            "RainbowCyan",
        }
        local hooks = require "ibl.hooks"
        hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
            vim.api.nvim_set_hl(0, "RainbowGreen",  { fg = "#98C379" })
            vim.api.nvim_set_hl(0, "RainbowYellow", { fg = "#E5C07B" })
            vim.api.nvim_set_hl(0, "RainbowCyan",   { fg = "#56B6C2" })
            vim.api.nvim_set_hl(0, "RainbowBlue",   { fg = "#61AFEF" })
            vim.api.nvim_set_hl(0, "RainbowRed",    { fg = "#E06C75" })
            vim.api.nvim_set_hl(0, "RainbowViolet", { fg = "#CB85E0" })
            vim.api.nvim_set_hl(0, "CurrentScope",  { fg = "#6fe77c"})
        end)


        require("ibl").setup({
            -- indent = { highlight = highlight, char = "▎" },
            -- indent = { highlight = highlight, char = "▏" ,},
            indent = { highlight = highlight, char = "│" ,},
            scope ={
                enabled          = false,
                highlight        = { "CurrentScope"},
                char             = "┃", -- ┃ ║
                show_start       = false,
                show_end         = false,
                show_exact_scope = false,
                include          = {node_type = { ["*"] = { "*" } }}
            }
        })
        vim.g.rainbow_delimiters = { highlight = highlight }

        -- Toggle indent-blankline when entering visual mode
        local indent_blankline_augroup = vim.api.nvim_create_augroup("indent_blankline_augroup", {clear = true})
        vim.api.nvim_create_autocmd("ModeChanged", {
            group = indent_blankline_augroup,
            pattern = "[vV\x16]*:*",
            command = "IBLEnable",
            desc = "Enable indent-blankline when exiting visual mode"
        })

        vim.api.nvim_create_autocmd("ModeChanged", {
            group = indent_blankline_augroup,
            pattern = "*:[vV\x16]*",
            command = "IBLDisable",
            desc = "Disable indent-blankline when exiting visual mode"
        })
        hooks.register(hooks.type.SCOPE_HIGHLIGHT, hooks.builtin.scope_highlight_from_extmark)
    end

}
