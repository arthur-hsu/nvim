return {
    "folke/persistence.nvim",
    opts = { options = { "buffers", "curdir", "tabpages", "winsize", "help", "globals" } },
    keys = {
        { "<leader>rs", function() require("persistence").select() end,                desc = "select a session to load" },
        { "<leader>rl", function() require("persistence").load({ last = true }) end, desc = "Restore Last Session" },
        { "<leader>rd", function() require("persistence").stop() end,                desc = "Don't Save Current Session" },
    },
}
