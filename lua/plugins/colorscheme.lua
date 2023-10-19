return {
    {
        'lunarvim/darkplus.nvim',
        priority = 1000,
    },
    {
        "arthur-hsu/zephyr-nvim",
        lazy = false,
        priority = 1000,
        config = function ()
            vim.cmd.colorscheme "zephyr"
        end
    },
    {
        'AlexvZyl/nordic.nvim',
        --lazy = false,
        priority = 1000,
        config = function()
            local palette = require 'nordic.colors'
            require('nordic').setup({
                transparent_bg = true,
                bold_keywords = true,
            })
            require 'nordic' .load()
        end
    },
    {
        "rebelot/kanagawa.nvim",
        priority = 1000,
        opts = function ()
            return{
                compile = false,             -- enable compiling the colorscheme
                undercurl = true,            -- enable undercurls
                commentStyle = { italic = true },
                functionStyle = {},
                keywordStyle = { italic = true},
                statementStyle = { bold = true },
                typeStyle = {},
                transparent = false,         -- do not set background color
                dimInactive = false,         -- dim inactive window `:h hl-NormalNC`
                terminalColors = true,       -- define vim.g.terminal_color_{0,17}
                colors = {                   -- add/modify theme and palette colors
                    palette = {},
                    theme = { wave = {}, lotus = {}, dragon = {}, all = {} },
                },
                overrides = function(colors) -- add/modify highlights
                    return {

                    }
                end,
                theme = "wave",              -- Load "wave" theme when 'background' option is not set
                background = {               -- map the value of 'background' option to a theme
                    dark = "dragon",           -- try "dragon" !
                    light = "lotus"
                },
            }
        end
    },
    {
        "folke/tokyonight.nvim",
        priority = 1000,
        opts = function()
            return {
                style = "night",        ---- The theme comes in three styles, `storm`, `moon`, a darker variant `night` and `day`
                -- transparent = true,
                -- styles = {
                --   sidebars = "transparent",
                --   floats = "transparent",
                -- },
                sidebars = {
                    "qf",
                    "vista_kind",
                    "terminal",
                    "spectre_panel",
                    "startuptime",
                    "Outline",
                },
                on_colors = function(c)
                  -- local hsluv = require("tokyonight.hsluv")
                  -- local function randomColor(color)
                  --   if color ~= "NONE" then
                  --     local hsl = hsluv.hex_to_hsluv(color)
                  --     hsl[1] = math.random(0, 360)
                  --     return hsluv.hsluv_to_hex(hsl)
                  --   end
                  --   return color
                  -- end
                  -- local function set(colors)
                  --   if type(colors) == "table" then
                  --     for k, v in pairs(colors) do
                  --       if type(v) == "string" then
                  --         colors[k] = randomColor(v)
                  --       elseif type(v) == "table" then
                  --         set(v)
                  --       end
                  --     end
                  --   end
                  -- end
                  -- set(c)
                end,
                on_highlights = function(hl, c)
                    hl.CursorLineNr = { fg = c.orange, bold = true }
                    hl.LineNr = { fg = c.orange, bold = true }
                    hl.LineNrAbove = { fg = c.fg_gutter }
                    hl.LineNrBelow = { fg = c.fg_gutter }
                    local prompt = "#2d3149"
                    hl.TelescopeNormal = { bg = c.bg_dark, fg = c.fg_dark }
                    hl.TelescopeBorder = { bg = c.bg_dark, fg = c.bg_dark }
                    hl.TelescopePromptNormal = { bg = prompt }
                    hl.TelescopePromptBorder = { bg = prompt, fg = prompt }
                    hl.TelescopePromptTitle = { bg = c.fg_gutter, fg = c.orange }
                    hl.TelescopePreviewTitle = { bg = c.bg_dark, fg = c.bg_dark }
                    hl.TelescopeResultsTitle = { bg = c.bg_dark, fg = c.bg_dark }
                end,
            }
        end,
    },
}
