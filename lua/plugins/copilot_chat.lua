return {
    {
        "CopilotC-Nvim/CopilotChat.nvim",
        branch = "canary",
        event = "VeryLazy",
        dependencies = {
            { "zbirenbaum/copilot.lua" }, -- or github/copilot.vim
            { "nvim-lua/plenary.nvim" }, -- for curl, log wrapper
            { "nvim-telescope/telescope.nvim" }, -- for telescope help actions (optional)
        },
        opts = {
            auto_follow_cursor = false, -- Don't follow the cursor after getting response
            window = {
                layout = 'float', -- 'vertical', 'horizontal', 'float'
                -- Options below only apply to floating windows
                relative = 'editor', -- 'editor', 'win', 'cursor', 'mouse'
                border = 'single', -- 'none', single', 'double', 'rounded', 'solid', 'shadow'
                width = 0.8, -- fractional width of parent
                height = 0.6, -- fractional height of parent
                row = nil, -- row position of the window, default is centered
                col = nil, -- column position of the window, default is centered
                title = 'Copilot Chat', -- title of chat window
                footer = nil, -- footer of chat window
                zindex = 1, -- determines if window is on top or below other floating windows
            },
            mappings = {
                close = "q", -- Close chat
                reset = "<C-l>", -- Clear the chat buffer
                complete = "<Tab>", -- Change to insert mode and press tab to get the completion
                submit_prompt = "<CR>", -- Submit question to Copilot Chat
                accept_diff = "<C-a>", -- Accept the diff
                show_diff = "<C-s>", -- Show the diff
            },
        },

        config = function(_,opts)
            local chat = require("CopilotChat")
            local select = require("CopilotChat.select")

            local prompts = {
                Explain = {
                    prompt = '解釋這段代碼如何運行。',
                    -- selection = select.buffer,
                },
                FixError = {
                    prompt = ' 請解釋下面文字中的錯誤並提供解決方案。',
                    selection = select.diagnostics,
                },
                Suggestion = {
                    prompt = " 請查看以下程式碼並提供改進建議。",
                    -- selection = select.buffer,
                },
                Refactor = {
                    prompt = "請重構以下程式碼以提高其清晰度和可讀性。",
                    -- selection = select.buffer,
                },

                SelectExplain = {
                    prompt = '解釋這段代碼如何運行。',
                    selection = select.visual,
                },
                SelectFixError = {
                    prompt = '請解釋下面文字中的錯誤並提供解決方案。',
                    selection = select.visual,
                },
                SelectSuggestion = {
                    prompt = " 請查看以下程式碼並提供改進建議。",
                    selection = select.visual,
                },
                SelectRefactor = {
                    prompt = "請重構以下程式碼以提高其清晰度和可讀性。",
                    selection = select.visual,
                },
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
                Tests = {
                    prompt = '簡要說明所選程式碼的工作原理，然後產生單元測試。',
                    selection = select.buffer,
                },
            }
            opts.prompts = prompts
            opts.selection = select.unnamed
            -- Use unnamed register for the selection

            chat.setup(opts)


        end,
        keys = {
            {
                '<leader>cci',
                function()
                    local input = vim.fn.input("Quick Chat: ")
                    if input ~= "" then
                        require("CopilotChat").ask(input, { selection = require("CopilotChat.select").buffer })
                    end
                end,
                desc = "CopilotChat - Quick chat",
                mode = {"n","v","x"}
            },
            {
                '<leader>ccp',
                function()
                    require("CopilotChat.code_actions").show_prompt_actions()
                end,
                desc = "CopilotChat - Prompt actions",
                mode = {"n","v","x"}
            },
            { '<leader>ccq', "<cmd>CopilotChatClose<cr>",            desc = "Close chat",                     mode = {"n",  "v", "x"} },
            { '<leader>cct', "<cmd>CopilotChatToggle<cr>",           desc = "Toggle chat",                    mode = {"n",  "v", "x"} },
            { '<leader>ccR', "<cmd>CopilotChatReset<cr>",            desc = "Reset chat",                     mode = {"n",  "v", "x"} },
            { '<leader>ccD', "<cmd>CopilotChatDebugInfo<cr>",        desc = "Show diff",                      mode = {"n",  "v", "x"} },

            { '<leader>cce', "<cmd>CopilotChatExplain<cr>",          desc = "Explain code",                   mode = "n" },
            { '<leader>ccT', "<cmd>CopilotChatFixError<cr>",         desc = "Fix Error",                      mode = "n" },
            { '<leader>ccr', "<cmd>CopilotChatSuggestion<cr>",       desc = "Provide suggestion",             mode = "n" },
            { '<leader>ccF', "<cmd>CopilotChatRefactor<cr>",         desc = "Refactor code",                  mode = "n" },

            { '<leader>cce', "<cmd>CopilotChatSelectExplain<cr>",    desc = "Explain for seleced",            mode = {"n",  "x", "v"} },
            { '<leader>ccT', "<cmd>CopilotChatSelectFixError<cr>",   desc = "Fix error for seleced",          mode = {"n",  "x", "v"} },
            { '<leader>ccr', "<cmd>CopilotChatSelectSuggestion<cr>", desc = "Provide suggestion for seleced", mode = {"n",  "x", "v"} },
            { '<leader>ccF', "<cmd>CopilotChatSelectRefactor<cr>",   desc = "Refactor for selected",          mode = {"n",  "x", "v"} },
        }
    },
}
