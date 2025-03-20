return {
    "CopilotC-Nvim/CopilotChat.nvim",
    event = "VeryLazy",
    dependencies = {
        { "zbirenbaum/copilot.lua" },        -- or github/copilot.vim
        { "nvim-lua/plenary.nvim" },         -- for curl, log wrapper
        -- { "nvim-telescope/telescope.nvim" }, -- for telescope help actions (optional)
    },
    opts = {
        model             = "claude-3.7-sonnet-thought",
        debug             = false,
        log_level         = "fatal",
        question_header   = '  User ', -- Header to use for user questions
        answer_header     = '  Copilot ', -- Header to use for AI answers
        error_header      = '  Error ', -- Header to use for errors
        chat_autocomplete = false,
        window            = {
            border = 'rounded', -- 'none', single', 'double', 'rounded', 'solid', 'shadow'
            width = 0.5, -- fractional width of parent
            height = 0.6, -- fractional height of parent
            title = '  CopilotChat ', -- title of chat window
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
        local select = require("CopilotChat.select")
        local func = require("plugins.Copilotchat.func")
        local prompts = {
            QuickChat             = {},
            Translate             = { prompt = "> /COPILOT_GENERATE\n\n將英文翻譯成繁體中文, 或是將中文翻譯成英文, 回答中不需要包含行數" },
            Commit                = {
                prompt =
                '使用繁體中文詳盡的總結這次提交的更改，並使用 commitizen 慣例總結提交內容，消息包涵標題以及改動的細項。確保標題最多 50 個字符，消息在 72 個字符處換行。將整個消息用 gitcommit 語言的代碼塊包裹起來。',
                sticky = '#git:unstaged',
                selection = false,
                callback = function(response, source)
                    func.commit_callback(response, source, false)
                end
            },
            CommitStaged          = {
                -- prompt            = 'Write commit message for the change with commitizen convention. Make sure the title has maximum 50 characters and message is wrapped at 72 characters. Wrap the whole message in code block with language gitcommit.',
                prompt =
                '使用繁體中文詳盡的總結這次提交的更改，並使用 commitizen 慣例總結提交內容，消息包涵標題以及改動的細項。確保標題最多 50 個字符，消息在 72 個字符處換行。將整個消息用 gitcommit 語言的代碼塊包裹起來。',
                sticky = '#git:staged',
                selection = false,
                callback = function(response, source)
                    func.commit_callback(response, source, true)
                end,
            },
        }
        opts.prompts = prompts
        require("CopilotChat").setup(opts)
        vim.api.nvim_create_autocmd('BufEnter', {
            pattern = 'copilot-*',
            callback = function()
                vim.opt_local.relativenumber = false
                vim.opt_local.number         = false

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

