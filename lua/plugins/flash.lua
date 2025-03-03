return {
    "folke/flash.nvim",
    -- enabled = false,
    event = "VeryLazy",
    -- stylua: ignore
    keys = {
        { "s",     mode = { "n" },      function () require("flash").jump()              end , desc = "flash" },
        { "S",     mode = { "n" },      function () require("flash").treesitter()        end , desc = "flash treesitter" },
        { "<C-s>", mode = { "x", "o" }, function () require("flash").jump()              end , desc = "flash" },
        { "<C-s>", mode = { "c" },      function () require("flash").toggle()            end , desc = "toggle flash search" },
        { "r",     mode = "o",               function() require("flash").remote()            end , desc = "remote flash" },
        { "R",     mode = { "o", "x" },      function() require("flash").treesitter_search() end , desc = "treesitter search" },
    },
    config = function()
        require("flash").setup({
            search = {
                label = {
                    uppercase = false,
                }
            },
            modes = {
                search = {
                    enabled = false,
                },
                char = {
                    enabled = true,
                    keys = { "f", "F" },
                    ---@alias Flash.CharActions table<string, "next" | "prev" | "right" | "left">
                    -- The direction for `prev` and `next` is determined by the motion.
                    -- `left` and `right` are always left and right.
                    char_actions = function(motion)
                        return {
                            [";"] = "next", -- set to `right` to always go right
                            [","] = "prev", -- set to `left` to always go left
                            -- clever-f style
                            [motion:lower()] = "next",
                            [motion:upper()] = "prev",
                            -- jump2d style: same case goes next, opposite case goes prev
                            -- [motion] = "next",
                            -- [motion:match("%l") and motion:upper() or motion:lower()] = "prev",
                        }
                    end
                }
            },
            label = {
                style = "inline",
                rainbow = {
                    enabled = true,
                    -- number between 1 and 9
                    shade = 7,
                },
            }
        })
        vim.api.nvim_set_hl(0, "FlashBackdrop",   { link = "Comment" })
        vim.api.nvim_set_hl(0, "FlashMatch",      { link = "Search" })
        vim.api.nvim_set_hl(0, "FlashCurrent",    { link = "CurSearch" })
        vim.api.nvim_set_hl(0, "FlashLabel",      { bg = "#e1e1fc", fg = "#FF007C", bold = true ,italic=true})
        -- vim.api.nvim_set_hl(0, "FlashLabel",      { bg = "#00ff83", fg = "#FF007C", bold = true ,italic=true})

        vim.api.nvim_set_hl(0, "FlashCursor",     { fg = "#b3b8f5", bg = "#88D97B", bold = true })
        vim.api.nvim_set_hl(0, "FlashPrompt",     { link= "MsgArea" })
        vim.api.nvim_set_hl(0, "FlashPromptIcon", { link= "Special" })
    end
}
