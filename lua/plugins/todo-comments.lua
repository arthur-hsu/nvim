return {
    {
        "folke/todo-comments.nvim",
        event = "BufRead",
        dependencies = { "nvim-lua/plenary.nvim"},
        -- opts = {
        -- },
        config = function()
            require('todo-comments').setup({
                keywords = {
                    tag = { icon = "󰌕 ", color = "tag",alt = { "RAW" } },
                    IMPORTANT = { icon = "󰂵 ", color = "error",alt = { "Important" } },
                    
                    FIX = {
                        icon = " ", -- icon used for the sign, and in search results
                        color = "error", -- can be a hex color, or a named color (see below)
                        alt = { "FIXME", "BUG", "FIXIT", "ISSUE" }, -- a set of other keywords that all map to this FIX keywords
                        -- signs = false, -- configure signs for some keywords individually
                    },
                    TODO = { icon = " ", color = "info" },
                    HACK = { icon = " ", color = "warning" },
                    WARN = { icon = " ", color = "warning",   alt = { "WARNING",  "XXX" } },
                    PERF = { icon = " ", alt = { "OPTIM",     "PERFORMANCE",      "OPTIMIZE" } },
                    NOTE = { icon = " ", color = "hint",      alt = { "INFO" } },
                    TEST = { icon = "⏲ ", color = "test",      alt = { "TESTING",  "PASSED",       "FAILED" } },
                },
                signs = false,
                sign_priority = 8, -- sign priority`
                highlight = {
                    multiline         = true, -- enable multine todo comments
                    multiline_pattern = "^.", -- lua pattern to match the next multiline from the start of the matched keyword
                    multiline_context = 10, -- extra lines that will be re-evaluated when changing a line
                    before            = "fg", -- "fg" or "bg" or empty
                    keyword           = "wide", -- "fg", "bg", "wide", "wide_bg", "wide_fg" or empty. (wide and wide_bg is the same as bg, but will also highlight surrounding characters, wide_fg acts accordingly but with fg)
                    after             = "fg", -- "fg" or "bg" or empty
                    -- pattern        = [[.*<(KEYWORDS)\s*:]], -- pattern or table of patterns, used for highlighting (vim regex)
                    pattern           = [[.*<(KEYWORDS)\s*]], -- pattern or table of patterns, used for highlighting (vim regex)
                    comments_only     = true, -- uses treesitter to match keywords in comments only
                    max_line_len      = 400, -- ignore lines longer than this
                    exclude           = {}, -- list of file types to exclude highlighting
                },
                -- note:
                colors = {
                    tag = {'tag', '#FFD700'},
                    actionItem = { "ActionItem", "#A0CC00" },
                    argumentation = { "Argument", "#8C268C" },
                    default = { "Identifier", "#999999" },
                    error = { "LspDiagnosticsDefaultError", "ErrorMsg", "#DC2626" },
                    idea = { "IdeaMsg", "#FDFF74" },
                    info = { "LspDiagnosticsDefaultInformation", "#2563EB" },
                    warning = { "LspDiagnosticsDefaultWarning", "WarningMsg", "#FB8F24" },
                },
                search = {
                    command = "rg",
                    args = {
                        "--color=never",
                        "--no-heading",
                        "--with-filename",
                        "--line-number",
                        "--column",
                        -- "--ignore-case"
                    },
                    -- regex that will be used to match keywords.
                    -- don't replace the (KEYWORDS) placeholder
                    -- pattern = [[\b(KEYWORDS):]], -- ripgrep regex
                    pattern = [[\b(KEYWORDS)\b]], -- match without the extra colon. You'll likely get false positives
                },
            })

            vim.keymap.set("n", "]t", function()
                require("todo-comments").jump_next()
            end, { desc = "Next todo comment" })

            vim.keymap.set("n", "[t", function()
                require("todo-comments").jump_prev()
            end, { desc = "Previous todo comment" })
        end
    }
}
