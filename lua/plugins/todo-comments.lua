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
                    tag = { icon = "󰌕 ", color = "tag" },
                },
                signs = false,
                sign_priority = 8, -- sign priority`
                highlight = {
                    multiline = true, -- enable multine todo comments
                    multiline_pattern = "^.", -- lua pattern to match the next multiline from the start of the matched keyword
                    multiline_context = 10, -- extra lines that will be re-evaluated when changing a line
                    before = "fg", -- "fg" or "bg" or empty
                    keyword = "wide", -- "fg", "bg", "wide", "wide_bg", "wide_fg" or empty. (wide and wide_bg is the same as bg, but will also highlight surrounding characters, wide_fg acts accordingly but with fg)
                    after = "fg", -- "fg" or "bg" or empty
                    pattern = [[.*<(KEYWORDS)\s*:]], -- pattern or table of patterns, used for highlighting (vim regex)
                    comments_only = true, -- uses treesitter to match keywords in comments only
                    max_line_len = 400, -- ignore lines longer than this
                    exclude = {'py'}, -- list of file types to exclude highlighting
                },
                colors = {
                    tag = {'tag', '#FFD700'},
                }
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
