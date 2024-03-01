return     {
        -- NOTE: highlight CursorWord
        "sontungexpt/stcursorword",
        event = "VeryLazy",
        config = function ()
            -- default configuration
            require("stcursorword").setup({
                max_word_length = 100, -- if cursorword length > max_word_length then not highlight
                min_word_length = 2, -- if cursorword length < min_word_length then not highlight
                excluded = {
                    filetypes = {
                        "TelescopePrompt",
                        "alpha",
                        "mason",
                        "lazy",
                        "DiffviewFileHistory",
                        "DiffviewFiles",
                        "Trouble",
                        "lspinfo"
                    },
                    buftypes = {
                        "nofile",
                        "help",
                        "terminal",
                    },
                    patterns = { -- the pattern to match with the file path
                    -- "%.png$",
                    -- "%.jpg$",
                    -- "%.jpeg$",
                    -- "%.pdf$",
                    -- "%.zip$",
                    -- "%.tar$",
                    -- "%.tar%.gz$",
                    -- "%.tar%.xz$",
                    -- "%.tar%.bz2$",
                    -- "%.rar$",
                    -- "%.7z$",
                    -- "%.mp3$",
                    -- "%.mp4$",
                },
            },
            highlight = {
                underline = true,
                -- reverse = true,
                bg=nil,
                fg = nil,
                bold = true,
                -- bg = '#191919',
                -- fg = '#b3b8f5',
            },
        })
        -- define a variable to store the current state of the cursorword highlight
        local cursorword_highlight_enabled = true

        -- Toggle the cursorword highlight
        function ToggleCursorWordHighlight()
            if cursorword_highlight_enabled then
                -- If the current state is enabled, then execute the disable command
                vim.cmd('CursorwordDisable')
                cursorword_highlight_enabled = false
            else
                -- Else, execute the enable command
                vim.cmd('CursorwordEnable')
                cursorword_highlight_enabled = true
            end
        end
        -- Register the `CursorwordToggle` command
        vim.api.nvim_create_user_command('CursorwordToggle', ToggleCursorWordHighlight, {})
        vim.cmd('CursorwordToggle')

        end
}

