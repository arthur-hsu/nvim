return {
    "folke/flash.nvim",
    -- enabled = false,
    event = "VeryLazy",
    ---@type flash.config
    opts = {
        char={
            enabled = false,
            keys = { "f", "f", ";", "," },
        },
        modes = {
            search = {
                enabled=false,
        },
        }
    },
    -- stylua: ignore
    keys = {
        { "s",     mode = { "n", "x", "o" }, function() require("flash").jump()              end , desc = "flash" },
        { "S",     mode = { "n", "x", "o" }, function() require("flash").treesitter()        end , desc = "flash treesitter" },
        { "<c-s>", mode = { "c" },           function() require("flash").toggle()            end , desc = "toggle flash search" },
        -- { "r",     mode = "o",               function() require("flash").remote()            end , desc = "remote flash" },
        -- { "r",     mode = { "o", "x" },      function() require("flash").treesitter_search() end , desc = "treesitter search" },
    },
}
