return {
    {
        'folke/snacks.nvim',
        priority = 1000,
        lazy = false,
        opts = {
            bigfile      = { enabled = true },
            quickfile    = { enabled = true },
            statuscolumn = { enabled = false },
            words        = { enabled = false },
            terminal     = { enabled = true },
            scroll = {
                animate = {
                    duration = { step = 15, total = 250 },
                    easing = "linear",
                },
                spamming = 10, -- threshold for spamming detection
                -- what buffers to animate
                filter = function(buf)
                    return vim.g.snacks_scroll ~= false and vim.b[buf].snacks_scroll ~= false and vim.bo[buf].buftype ~= "terminal"
                end,
            },
            notifier = {
                enabled = true,
                timeout = 3000,
            },
            dashboard = {
                enabled = false,
                bo = {
                    -- filetype = "alpha",
                },
                wo = {
                    -- fillchars = [[eob: ,fold: ,foldopen: ,foldsep: ,foldclose: ]]
                },
                keys = {
                    { icon = " ", key = "f", desc = "Find File", action = ":lua Snacks.dashboard.pick('files')" },
                    { icon = " ", key = "n", desc = "New File", action = ":ene | startinsert" },
                    { icon = " ", key = "g", desc = "Find Text", action = ":lua Snacks.dashboard.pick('live_grep')" },
                    { icon = " ", key = "v", desc = "View change", action = ":DiffviewToggle <CR>" },
                    { icon = " ", key = "r", desc = "Recent Files", action = ":lua Snacks.dashboard.pick('oldfiles')" },
                    { icon = " ", key = "c", desc = "Config", action = ":lua Snacks.dashboard.pick('files', {cwd = vim.fn.stdpath('config')})" },
                    { icon = " ", key = "s", desc = "Restore Session" --[[ , section = "session" ]], action = [[:lua require("persistence").load() <cr>]] },
                    { icon = "󰒲 ", key = "L", desc = "Lazy", action = ":Lazy", enabled = package.loaded.lazy ~= nil },
                    { icon = " ", key = "q", desc = "Quit", action = ":qa" },
                },
                sections = {
                    { section = "header" },
                    -- {
                    --     section = "terminal",
                    --     cmd = "pokemon-colorscripts -r --no-title; sleep .1",
                    --     random = 10,
                    --     pane = 2,
                    --     padding = 1,
                    --     height = 30,
                    -- },
                    { section = "keys", gap = 1, padding = 1 },
                    { pane = 2, icon = " ", title = "Recent Files", section = "recent_files", indent = 2, padding = 1 },
                    { pane = 2, icon = " ", title = "Projects", section = "projects", indent = 2, padding = 1 },
                    {
                        pane = 2,
                        icon = " ",
                        title = "Git Status",
                        section = "terminal",
                        enabled = function()
                            return Snacks.git.get_root() ~= nil
                        end,
                        cmd = "hub status --short --branch --renames",
                        height = 5,
                        padding = 1,
                        ttl = 5 * 60,
                        indent = 3,
                    },
                    { section = "startup" },
                },
            },
        },
    },
}
