local color_register = function(color)
    vim.cmd.colorscheme(color)
end
return {
    {
        "arthur-hsu/zephyr-nvim",
        lazy = false,
        priority = 1000,
        config = function ()
            color_register("zephyr")
        end
    },
    {
        "olimorris/onedarkpro.nvim",
        event = "VeryLazy",
        priority = 1000, -- Ensure it loads first
        opts = {
                highlights = {
                    CursorLineNr = {
                        fg = "${purple}",
                        bg = nil
                    },
                },
                options = {
                    transparency = true
                }

        },
        config = function(_, opts)
            require("onedarkpro").setup(opts)
            -- color_register("onedark_dark")
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
    --                 comments = { italic = true },
    --                 keywords = { italic = true },
    --                 functions = {bold = true},
    --                 variables = {},
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
    -- },



    {
        'marko-cerovac/material.nvim',
        -- lazy = false,
        event = "VeryLazy",
        priority = 1000,
        config = function ()
            require('material').setup({
                contrast = {
                    terminal = true,              -- Enable contrast for the built-in terminal
                    sidebars = false,             -- Enable contrast for sidebar-like windows ( for example Nvim-Tree )
                    floating_windows = true,      -- Enable contrast for floating windows
                    cursor_line = false,          -- Enable darker background for the cursor line
                    non_current_windows = false,  -- Enable contrasted background for non-current windows
                    filetypes = {},               -- Specify which filetypes get the contrasted (darker) background
                },

                styles = { -- Give comments style such as bold, italic, underline etc.
                    comments = {  italic = true  },
                    strings = {   bold = false   },
                    keywords = {  bold = true,underline = false  },
                    functions = { bold = true, undercurl = false },
                    variables = {},
                    operators = {},
                    types = {},
                },

                plugins = { -- Uncomment the plugins that you use to highlight them
                    -- Available plugins:
                    "dap",
                    "flash",
                    "gitsigns",
                    "indent-blankline",
                    "lspsaga",
                    "noice",
                    "nvim-cmp",
                    -- "nvim-tree",
                    "nvim-web-devicons",
                    "telescope",
                    "trouble",
                    "which-key",
                    "nvim-notify",
                },

                disable = {
                    colored_cursor = false,  -- Disable the colored cursor
                    borders = false,         -- Disable borders between verticaly split windows
                    background = false,      -- Prevent the theme from setting the background (NeoVim then uses your terminal background)
                    term_colors = false,     -- Prevent the theme from setting terminal colors
                    eob_lines = false        -- Hide the end-of-buffer lines
                },

                high_visibility = {
                    lighter = true, -- Enable higher contrast text for lighter style
                    darker = true   -- Enable higher contrast text for darker style
                },

                lualine_style = "default",  -- Lualine style ( can be 'stealth' or 'default' )
                async_loading = true,       -- Load parts of the theme asyncronously for faster startup (turned on by default)
                custom_colors = nil,        -- If you want to override the default colors, set this to a function
                custom_highlights = {},     -- Overwrite highlights with your own
            })
            -- vim.g.material_style = "deep ocean"
            vim.g.material_style = "oceanic"
            -- color_register("material")
        end
    }
}

