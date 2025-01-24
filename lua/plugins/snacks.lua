local styles = {
    dashboard = {
        wo = {
            foldmethod     = "marker",
        }
    }
}

local the_edge =[[
   ▄   ▄███▄   ████▄     ▄   ▄█ █▀▄▀█
    █  █▀   ▀  █   █      █  ██ █ █ █
██   █ ██▄▄    █   █ █     █ ██ █ ▄ █
█ █  █ █▄   ▄▀ ▀████  █    █ ▐█ █   █
█  █ █ ▀███▀           █  █   ▐    █ 
█   ██                  █▐        ▀  
                        ▐            ]]

return {
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,
    opts = {
        styles       = styles,
        bigfile      = { enabled = true },
        quickfile    = { enabled = true },
        words        = { enabled = false },
        terminal     = { enabled = true },
        indent       = {
            enabled = false,
            indent = {
                priority = 1,
                enabled = true,       -- enable indent guides
                char = "│",
                only_scope = false,   -- only show indent guides of the scope
                only_current = true, -- only show indent guides in the current window
                -- hl = highlight,
                hl = {
                    "SnacksIndent1",
                    "SnacksIndent2",
                    "SnacksIndent3",
                    "SnacksIndent4",
                    "SnacksIndent5",
                    "SnacksIndent6",
                    "SnacksIndent7",
                    "SnacksIndent8"
                },
            },
            scope = {
                enabled = true, -- enable highlighting the current scope
                priority = 200,
                -- char = "┃",
                char = "│",
                underline = false,    -- underline the start of the scope
                only_current = true, -- only show scope in the current window
                hl = "CurrentScope", ---@type string|string[] hl group for scopes
            },
        },
        statuscolumn = {
            -- enabled = false,
            left    = { "fold", "git" }, -- priority of signs on the right (high to low)
            right   = { "sign" },        -- priority of signs on the left (high to low)
            folds   = {
                open   = true,           -- show open fold icons
                git_hl = true,           -- use Git Signs hl for fold icons
            },
            git     = {
                -- patterns to match Git signs
                patterns = { "GitSign", "MiniDiffSign" },
            },
            refresh = 50, -- refresh at most every 50ms
        },
        scroll       = {
            animate = {
                duration = { step = 15, total = 250 },
                easing = "linear",
            },
            spamming = 10, -- threshold for spamming detection
            -- what buffers to animate
            filter = function(buf)
                return vim.g.snacks_scroll ~= false and vim.b[buf].snacks_scroll ~= false and
                    vim.bo[buf].buftype ~= "terminal"
            end,
        },
        notifier     = {
            enabled = true,
            timeout = 3000,
        },
        dashboard    = {
            -- enabled = false,
            preset = {
                header = the_edge,
                keys = {
                    { icon = " ", key = "f", desc = "Find File", action = ":lua Snacks.dashboard.pick('files')" },
                    { icon = " ", key = "n", desc = "New File", action = ":ene | startinsert" },
                    { icon = " ", key = "g", desc = "Find Text", action = ":lua Snacks.dashboard.pick('live_grep')" },
                    { icon = " ", key = "v", desc = "View change", action = ":DiffviewToggle" },
                    { icon = " ", key = "r", desc = "Recent Files", action = ":lua Snacks.dashboard.pick('oldfiles')" },
                    { icon = " ", key = "c", desc = "Config", action = ":lua Snacks.dashboard.pick('files', {cwd = vim.fn.stdpath('config')})" },
                    { icon = " ", key = "s", desc = "Restore Session" --[[ , section = "session" ]], action = ":lua require('persistence').load()" },
                    { icon = "󰒲 ", key = "L", desc = "Lazy", action = ":Lazy", enabled = package.loaded.lazy ~= nil },
                    { icon = " ", key = "q", desc = "Quit", action = ":qa" },
                }
            },
            sections = {
                { section = "header" },
                {
                    section = "terminal",
                    random = 10,
                    cmd = "python3 /home/arthur/.config/nvim/shell/matrix.py",
                    pane = 2,
                    padding = 1,
                    height = 8,
                },
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
                    cmd = "git --no-pager diff --stat -B -M -C",
                    height = 5,
                    ttl = 5 * 60,
                    padding = 1,
                    indent = 2,
                },
                { section = "startup" },
            },
        },
    },
}
