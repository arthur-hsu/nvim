local prompt = require("plugins.Copilotchat.prompt")
return {
    "CopilotC-Nvim/CopilotChat.nvim",
    event = "VeryLazy",
    dependencies = {
        { "zbirenbaum/copilot.lua" },        -- or github/copilot.vim
        { "nvim-lua/plenary.nvim" },         -- for curl, log wrapper
        -- { "nvim-telescope/telescope.nvim" }, -- for telescope help actions (optional)
    },
    opts = {
        model             = "gpt-4o",
        debug             = false,
        log_level         = "fatal",
        prompts           = prompt,
        question_header   = '  User ', -- Header to use for user questions
        answer_header     = '  Copilot ', -- Header to use for AI answers
        error_header      = '  Error ', -- Header to use for errors
        chat_autocomplete = false,
        window            = {
            border = 'rounded',          -- 'none', single', 'double', 'rounded', 'solid', 'shadow'
            width  = 0.5,               -- fractional width of parent
            height = 0.6,               -- fractional height of parent
            title  = '  CopilotChat ',  -- title of chat window
        },
        mappings          = {
            accept_diff = {
                normal = '<C-a>',
                insert = '<C-a>'
            },
        },
    },
    config = function(_, opts)
        vim.api.nvim_set_hl(0, "CopilotChatSpinner", { link = "DiagnosticVirtualTextInfo" })

        require("CopilotChat").setup(opts)

        vim.api.nvim_create_autocmd('BufEnter', {
            pattern = 'copilot-*',
            callback = function()
                vim.opt_local.relativenumber = false
                vim.opt_local.number         = false
                vim.opt_local.foldmethod     = "marker",
                -- C-p to print last response
                vim.keymap.set('n', '<C-p>', function()
                print(require("CopilotChat").response())
                end, { buffer = true, remap = true })
            end
        })
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
            desc = "CopilotChat - Quick chat",
            mode = { "n", "v", "x" }
        },
        {
            '<leader>ccp',
            function()
                local actions = require("CopilotChat.actions")
                require("CopilotChat.integrations.telescope").pick(actions.prompt_actions())
            end,
            desc = "CopilotChat - Prompt actions",
            mode = { "n", "v", "x" }
        },
        { '<leader>cco', "<cmd>CopilotChatToggle<cr>",      desc = "CopilotChat - Toggle chat",        mode = { "n", "v", "x" } },
        { '<leader>ccq', "<cmd>CopilotChatClose<cr>",       desc = "CopilotChat - Close chat",         mode = { "n", "v", "x" } },
        { '<leader>ccR', "<cmd>CopilotChatReset<cr>",       desc = "CopilotChat - Reset chat",         mode = { "n", "v", "x" } },

        { '<leader>cce', "<cmd>CopilotChatExplain<cr>",     desc = "CopilotChat - Explain code",       mode = { "n", "v", "x" } },
        { '<leader>ccT', "<cmd>CopilotChatFixError<cr>",    desc = "CopilotChat - Fix Error",          mode = { "n", "v", "x" } },
        { '<leader>ccr', "<cmd>CopilotChatSuggestion<cr>",  desc = "CopilotChat - Provide suggestion", mode = { "n", "v", "x" } },
        { '<leader>ccF', "<cmd>CopilotChatRefactor<cr>",    desc = "CopilotChat - Refactor code",      mode = { "n", "v", "x" } },
        { '<leader>ccA', "<cmd>CopilotChatAnnotations<cr>", desc = "CopilotChat - Add a comment",      mode = { "n", "v", "x" } },
    }
}

