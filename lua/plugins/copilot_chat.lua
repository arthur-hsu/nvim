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
            debug = false, -- Enable debugging
            -- See Configuration section for rest
        },
        -- See Commands section for default commands if you want to lazy load on them
        config = function()
            local wk = require("which-key")
            wk.register({
                ["<leader>cc"] = {
                    name = "CopilotChat",
                    q = {
                        function()
                            local input = vim.fn.input("Quick Chat: ")
                            if input ~= "" then
                                require("CopilotChat").ask(input, { selection = require("CopilotChat.select").buffer })
                            end
                        end,
                        "CopilotChat - Quick chat"
                    },
                    b = { "<cmd>CopilotChatBuffer<cr>", "Chat with current buffer" },
                    e = { "<cmd>CopilotChatExplain<cr>", "Explain code" },
                    t = { "<cmd>CopilotChatTests<cr>", "Generate tests" },
                    r = { "<cmd>CopilotChatReview<cr>", "Review code" },
                    R = { "<cmd>CopilotChatRefactor<cr>", "Refactor code" },
                }
            })
        end,
    },
}
