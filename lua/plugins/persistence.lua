return {
    {
        "folke/persistence.nvim",
        -- event = "BufReadPre",
        event = "VeryLazy",
        -- enabled = false,
        opts = { options = { "buffers", "curdir", "tabpages", "winsize", "help", "globals" } },
         --stylua: ignore
        keys = {
            { "<leader>rs", function() require("persistence").load() end,                desc = "Restore Session" },
            { "<leader>rl", function() require("persistence").load({ last = true }) end, desc = "Restore Last Session" },
            { "<leader>rd", function() require("persistence").stop() end,                desc = "Don't Save Current Session" },
        },
    },
}

