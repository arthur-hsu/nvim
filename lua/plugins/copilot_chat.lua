return {
    {
        "CopilotC-Nvim/CopilotChat.nvim",
        branch = "canary",
        event = "VeryLazy",
        dependencies = {
            { "zbirenbaum/copilot.lua" },                 -- or github/copilot.vim
            { "nvim-lua/plenary.nvim" },                  -- for curl, log wrapper
            { "nvim-telescope/telescope.nvim" },          -- for telescope help actions (optional)
        },
        opts = {
            model = 'gpt-4',                              -- GPT model to use
            temperature = 0.1,                            -- GPT temperature
            debug = false,                                -- Enable debug logging
            show_user_selection = true,                   -- Shows user selection in chat
            show_system_prompt = false,                   -- Shows system prompt in chat
            show_folds = true,                            -- Shows folds for sections in chat
            clear_chat_on_new_prompt = false,             -- Clears chat on every new prompt
            auto_follow_cursor = true,                    -- Auto-follow cursor in chat
            name = 'CopilotChat',                         -- Name to use in chat
            separator = '---',                            -- Separator to use in chat
            window = {
                layout = 'vertical',                      -- 'vertical', 'horizontal', 'float'
                                                          -- Options below only apply to floating windows
                relative = 'editor',                      -- 'editor', 'win', 'cursor', 'mouse'
                border = 'rounded',                       -- 'none', single', 'double', 'rounded', 'solid', 'shadow'
                width = 0.8,                              -- fractional width of parent
                height = 0.6,                             -- fractional height of parent
                row = nil,                                -- row position of the window, default is centered
                col = nil,                                -- column position of the window, default is centered
                title = '  CopilotChat ',                -- title of chat window
                footer = nil,                             -- footer of chat window
                zindex = 1,                               -- determines if window is on top or below other floating windows
            },
            mappings = {
                close = "q",                              -- Close chat
                reset = "<C-l>",                          -- Clear the chat buffer
                complete = "<Tab>",                       -- Change to insert mode and press tab to get the completion
                submit_prompt = "<CR>",                   -- Submit question to Copilot Chat
                accept_diff = "<C-a>",                    -- Accept the diff
                show_diff = "<C-s>",                      -- Show the diff
            },
        },

        config = function(_,opts)
            local select = require("CopilotChat.select")

            local prompts = {
                Explain    = { prompt = "解釋這段代碼如何運行。" },
                FixError   = { prompt = "請解釋下面文字中的錯誤並提供解決方案。" },
                Suggestion = { prompt = "請查看以下程式碼並提供改進建議。" },
                Refactor   = { prompt = "請重構以下程式碼以提高其清晰度和可讀性。" },
                Tests      = { prompt = "簡要說明所選程式碼的工作原理，然後產生單元測試。" },

                Commit = {
                    prompt = 'Write commit message for the change with commitizen convention. Make sure the title has maximum 50 characters and message is wrapped at 72 characters. Wrap the whole message in code block with language gitcommit.',
                    selection = select.gitdiff,
                },
                CommitStaged = {
                    prompt = 'Write commit message for the change with commitizen convention. Make sure the title has maximum 50 characters and message is wrapped at 72 characters. Wrap the whole message in code block with language gitcommit.',
                    selection = function(source)
                        return select.gitdiff(source, true)
                    end,
                },
            }

            opts.selection = function(source)
                local startPos = vim.fn.getpos("'<")
                local endPos   = vim.fn.getpos("'>")

                -- 检查是否有选择文本（即开始和结束位置是否不同）
                if startPos[2] ~= endPos[2] or startPos[3] ~= endPos[3] then
                    return select.visual(source)
                else
                    return select.buffer(source)
                end
            end

            opts.prompts = prompts
            require("CopilotChat").setup(opts)
        end,

        keys = {
            {
                '<leader>cci',
                function()
                    local input = vim.fn.input("Quick Chat: ")
                    if input ~= "" then
                        require("CopilotChat").ask(input)
                    end
                end,
                desc = " CopilotChat - Quick chat",
                mode = {"n","v","x"}
            },
            {
                '<leader>ccp',
                function()
                    require("CopilotChat.code_actions").show_prompt_actions()
                end,
                desc = " CopilotChat - Prompt actions",
                mode = {"n","v","x"}
            },
            { '<leader>cco', "<cmd>CopilotChatOpen<cr>",             desc = " CopilotChat - Open chat",                      mode = {"n",  "v", "x"} },
            { '<leader>ccq', "<cmd>CopilotChatClose<cr>",            desc = " CopilotChat - Close chat",                     mode = {"n",  "v", "x"} },
            { '<leader>cct', "<cmd>CopilotChatToggle<cr>",           desc = " CopilotChat - Toggle chat",                    mode = {"n",  "v", "x"} },
            { '<leader>ccR', "<cmd>CopilotChatReset<cr>",            desc = " CopilotChat - Reset chat",                     mode = {"n",  "v", "x"} },
            { '<leader>ccD', "<cmd>CopilotChatDebugInfo<cr>",        desc = " CopilotChat - Show diff",                      mode = {"n",  "v", "x"} },

            { '<leader>cce', "<cmd>CopilotChatExplain<cr>",          desc = " CopilotChat - Explain code",                   mode = {"n",  "v", "x"} },
            { '<leader>ccT', "<cmd>CopilotChatFixError<cr>",         desc = " CopilotChat - Fix Error",                      mode = {"n",  "v", "x"} },
            { '<leader>ccr', "<cmd>CopilotChatSuggestion<cr>",       desc = " CopilotChat - Provide suggestion",             mode = {"n",  "v", "x"} },
            { '<leader>ccF', "<cmd>CopilotChatRefactor<cr>",         desc = " CopilotChat - Refactor code",                  mode = {"n",  "v", "x"} },
        }
    },
}
