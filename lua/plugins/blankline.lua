local highlight = {
    "RainbowViolet",
    "RainbowYellow",
    "RainbowBlue",
    "RainbowGreen",
    "RainbowRed",
    "RainbowCyan",
}
vim.api.nvim_set_hl(0, "RainbowViolet", { fg = "#CB85E0" })
vim.api.nvim_set_hl(0, "RainbowYellow", { fg = "#E5C07B" })
vim.api.nvim_set_hl(0, "RainbowBlue",   { fg = "#61AFEF" })
vim.api.nvim_set_hl(0, "RainbowGreen",  { fg = "#98C379" })
vim.api.nvim_set_hl(0, "RainbowCyan",   { fg = "#56B6C2" })
vim.api.nvim_set_hl(0, "RainbowRed",    { fg = "#E06C75" })
vim.api.nvim_set_hl(0, "CurrentScope",  { fg = "#6FE77C" })
return {
    {
        'HiPhish/rainbow-delimiters.nvim',
        event = "VeryLazy",
        opts = function()
            return {
                highlight = highlight
            }
        end,
        config = function(_, opts)
            require 'rainbow-delimiters.setup'.setup(opts)
            require('rainbow-delimiters').enable()
        end,
    },
    {
        "lukas-reineke/indent-blankline.nvim",
        enabled = false,
        main = "ibl",
        dependencies = {
        },
        config = function()
            local hooks = require "ibl.hooks"
            hooks.register(
                hooks.type.HIGHLIGHT_SETUP,
                function()
                    vim.api.nvim_set_hl(0, "RainbowGreen",  { fg = "#98C379" })
                    vim.api.nvim_set_hl(0, "RainbowYellow", { fg = "#E5C07B" })
                    vim.api.nvim_set_hl(0, "RainbowCyan",   { fg = "#56B6C2" })
                    vim.api.nvim_set_hl(0, "RainbowBlue",   { fg = "#61AFEF" })
                    vim.api.nvim_set_hl(0, "RainbowRed",    { fg = "#E06C75" })
                    vim.api.nvim_set_hl(0, "RainbowViolet", { fg = "#CB85E0" })
                    vim.api.nvim_set_hl(0, "CurrentScope",  { fg = "#6fe77c" })
                end
            )
            require("ibl").setup({
                -- indent = { highlight = highlight, char = "▎" },
                -- indent = { highlight = highlight, char = "▏" ,},
                indent = { highlight = highlight, char = "│", },
                scope = {
                    enabled          = false,
                    highlight        = { "CurrentScope" },
                    char             = "┃", -- ┃ ║
                    show_start       = false,
                    show_end         = false,
                    show_exact_scope = false,
                    include          = { node_type = { ["*"] = { "*" } } }
                },
                exclude = {
                    filetypes = { "lazy" },
                    -- buftypes  = { "terminal" },
                }
            })
            -- Toggle indent-blankline when entering visual mode
            local indent_blankline_augroup = vim.api.nvim_create_augroup("indent_blankline_augroup", { clear = true })
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
}
