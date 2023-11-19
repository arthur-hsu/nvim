return {
    {
        "arthur-hsu/zephyr-nvim",
        lazy = false,
        priority = 1000,
        config = function ()
            vim.cmd.colorscheme "zephyr"
        end
    },
    -- {
    --     "folke/tokyonight.nvim",
    --     lazy = false,
    --     priority = 1000,
    --     opts = function()
    --         return {
    --             style = "night",        ---- The theme comes in three styles, `storm`, `moon`, a darker variant `night` and `day`
    --             transparent = true,
    --             hide_inactive_statusline = false,
    --             lualine_bold = true,
    --             styles = {
    --                 sidebars = "transparent",
    --                 floats = "transparent",
    --             },
    --             sidebars = {
    --                 "qf",
    --                 "vista_kind",
    --                 "terminal",
    --                 "spectre_panel",
    --                 "startuptime",
    --                 "Outline",
    --             },
    --         }
    --     end,
    --     -- config = function ()
    --     --     vim.cmd[[colorscheme tokyonight]]
    --     -- end,
    -- },
}
