local function find_lines_between_separator(lines, pattern, at_least_one)
    local line_count            = #lines
    local separator_line_start  = 1
    local separator_line_finish = line_count
    local found_one             = false

    -- Find the last occurrence of the separator
    for i = line_count, 1, -1 do             -- Reverse the loop to start from the end
        local line = lines[i]
        if string.find(line, pattern) then
            if i < (separator_line_finish + 1) and (not at_least_one or found_one) then
                separator_line_start = i + 1
                break             -- Exit the loop as soon as the condition is met
            end

            found_one = true
            separator_line_finish = i - 1
        end
    end

    if at_least_one and not found_one then
        return {}, 1, 1, 0
    end

    -- Extract everything between the last and next separator
    local result = {}
    for i = separator_line_start, separator_line_finish do
        table.insert(result, lines[i])
    end

    return result, separator_line_start, separator_line_finish, line_count
end

local commit_callback = function(response, source, staged)
    local bufnr    = source.bufnr
    local buftype  = vim.api.nvim_get_option_value('filetype', { buf = bufnr })
    local notify   = require("notify")
    local accept   = require("CopilotChat").config.mappings.accept_diff.normal
    local quit     = require("CopilotChat").config.mappings.close.normal
    local showdiff = require("CopilotChat").config.mappings.show_diff.normal
    local lines    = {}

    for line in response:gmatch("[^\r\n]+") do
        table.insert(lines, line)
    end

    local res, start_line, end_line, total_lines = find_lines_between_separator(lines, '^```%w*$', true)
    local max_line = 0
    for i, line in ipairs(res) do
        if #line > max_line then
            max_line = #line
        end
    end

    local result = table.concat(res, "\n")
    if total_lines == 0 then
        notify("No commit msg", "error", { title = "Git commit" })
        vim.api.nvim_input(quit)
        return
    end
    local separator = "\n" .. string.rep("─", max_line) .. "\n"
    local input = vim.fn.input("Commit message" .. separator .. result .. separator .. "auto commit? (y/n)")
    if string.match(input, 'y') then
        if string.match(buftype, 'gitcommit') then
            vim.api.nvim_input(accept)
            vim.api.nvim_input(quit)
        else
            local tmpfile = "/tmp/copilot_commit_msg"
            local file = io.open(tmpfile, "w")
            if not file then
                notify("Failed to open file: " .. tmpfile, "error", { title = "Git commit" })
                vim.api.nvim_input(quit)
                return
            end
            file:write(result)
            file:close()

            local add    = "git add -A"
            local commit = "git commit -F " .. tmpfile
            local push   = "git push"

            local cmd = ""

            if not staged then
                cmd = add .. " && "
            end
            local commit_cmd = cmd .. commit .. " && " .. push
            local _title = "Git commit"
            local first_notify = notify( "Committing changes in backend ...", "info", {
                title = _title,
                icon = "",
                on_open = function(win)
                    local buf = vim.api.nvim_win_get_buf(win)
                    vim.api.nvim_buf_set_option(buf, "filetype", "markdown")
                end
            })
            local handle
            handle = vim.loop.spawn(
                "sh", {
                    args  = { "-c", commit_cmd },
                    stdio = { nil, nil, nil },
                },
                function(code, signal)
                    handle:close()
                    os.remove(tmpfile)
                    if code == 0 then
                        local message = "Commit success" .. separator .. result
                        notify(message, "info", { title = _title, icon = "", replace = first_notify })
                    else
                        local message = "Commit fail, return code: " .. code .. " signal: " .. signal
                        notify(message, "error", { title = _title, icon = "", replace = first_notify })
                    end
                end
            )

            vim.api.nvim_input(quit)
        end
    else
        notify("Commit abort", "info", { title = "Git commit" })
    end
end


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
            window = {
                layout = 'vertical',                      -- 'vertical', 'horizontal', 'float'
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
                complete = {
                    detail = 'Use @<Tab> or /<Tab> for options.',
                    insert ='<Tab>',
                },
                close = {
                    normal = 'q',
                    insert = '<C-c>'
                },
                reset = {
                    normal ='<C-l>',
                    insert = '<C-l>'
                },
                submit_prompt = {
                    normal = '<CR>',
                    insert = '<C-m>'
                },
                accept_diff = {
                    normal = '<C-a>',
                    insert = '<C-a>'
                },
                show_diff = {
                    normal = 'gd'
                },
                show_system_prompt = {
                    normal = 'gp'
                },
                show_user_selection = {
                    normal = 'gs'
                },
            },
        },

        config = function(_,opts)

            local select = require("CopilotChat.select")

            opts.selection = function(source)
                local startPos = vim.fn.getpos("'<")
                local endPos   = vim.fn.getpos("'>")
                local startLine, startCol = startPos[2], startPos[3]
                local endLine,   endCol   = endPos[2],   endPos[3]

                if startLine ~= endLine or startCol ~= endCol then
                    return select.visual(source)
                else
                    return select.buffer(source)
                end
            end

            local prompts = {
                QuickChat             = {
                    selection = select.unnamed,
                },

                    -- selection = select.unnamed },
                QuickChatWithFiletype = {},
                Explain               = { prompt = "/COPILOT_EXPLAIN 解釋這段代碼如何運行。" },
                FixError              = { prompt = "/COPILOT_FIX 請解釋以上代碼中的錯誤並提供解決方案。" },
                Suggestion            = { prompt = "/COPILOT_REFACTOR 請查看以上代碼並提供改進建議的sample code。" },
                Annotations           = { prompt = "/COPILOT_REFACTOR 為所選程式編寫文件。 回覆應該是一個包含原始程式的程式塊，並將文件作為註釋新增。 為所使用的寫程式語言使用最合適的文件樣式（例如 JavaScript的JSDoc，Python的docstrings等)" },
                Refactor              = { prompt = "/COPILOT_REFACTOR 請重構以上代碼以提高其清晰度和可讀性。" },
                Tests                 = { prompt = "/COPILOT_TESTS 簡要說明以上代碼的工作原理，然後產生單元測試。" },
                FixDiagnostic = {
                    prompt = '/COPILOT_FIX Please assist with the following diagnostic issue in file:',
                    selection = select.diagnostics,
                },
                Commit = {
                    prompt = '使用中文總結這次提交的更改，並使用 commitizen 慣例編寫提交消息。確保標題最多 50 個字符，消息在 72 個字符處換行。將整個消息用 gitcommit 語言的代碼塊包裹起來。',
                    selection = select.gitdiff,
                    callback = function (response, source)
                        commit_callback(response, source, false)
                    end
                },
                CommitStaged = {
                    -- prompt            = 'Write commit message for the change with commitizen convention. Make sure the title has maximum 50 characters and message is wrapped at 72 characters. Wrap the whole message in code block with language gitcommit.',
                    prompt = '使用中文總結這次提交的更改，並使用 commitizen 慣例編寫提交消息。確保標題最多 50 個字符，消息在 72 個字符處換行。將整個消息用 gitcommit 語言的代碼塊包裹起來。',
                    -- prompt = '使用中文總結這次提交的更改，並使用 commitizen 慣例編寫提交消息。確保標題最多 50 個字符，消息在 72 個字符處換行。',
                    selection = function(source)
                        local bufnr = source.bufnr
                        local buftype = vim.api.nvim_get_option_value('filetype', { buf = bufnr })
                        if string.match(buftype, 'gitcommit') then
                            return opts.selection(source)
                        else
                            return select.gitdiff(source, true)
                        end
                    end,
                    callback = function (response, source)
                        commit_callback(response, source, true)
                    end,
                },
            }
            opts.prompts = prompts
            require("CopilotChat").setup(opts)

            -- NOTE: This function creates an unordered list.
            -- local options = {}
            -- table.insert(options, "Quick Chat")
            -- table.insert(options, "Quick Chat with file type")
            -- for key, value in pairs(prompts) do
            --     table.insert(options, key)
            -- end

            -- NOTE: So we need to create an ordered list.
            local options = {
                "QuickChat",    "QuickChatWithFiletype", "Explain",
                "FixError",     "Suggestion",            "Annotations",
                "Refactor",     "Tests",                 "Commit",
                "CommitStaged",
            }


            local pickers      = require "telescope.pickers"
            local finders      = require "telescope.finders"
            local conf         = require("telescope.config").values
            local actions      = require "telescope.actions"
            local action_state = require "telescope.actions.state"
            local Chat_cmd     = "CopilotChat"
            local Chat_prompts = require("CopilotChat").prompts()

            local Telescope_CopilotActions = function(opts)
                opts = opts or {}
                pickers.new(opts, {
                    prompt_title = "Select Copilot prompt",
                    finder = finders.new_table { results = options },
                    sorter = conf.generic_sorter(opts),

                    attach_mappings = function(prompt_bufnr, map)
                        actions.select_default:replace(function()
                            actions.close(prompt_bufnr)
                            local selected = action_state.get_selected_entry()
                            local choice = selected[1]
                            local get_type = vim.api.nvim_buf_get_option(0, 'filetype')
                            local FiletypeMsg = Chat_cmd .. " " .. "這是一段 ".. get_type .. " 代碼, "

                            local msg       = nil
                            local selection = nil
                            local callback  = nil
                            -- Find the item message and selection base on the choice
                            for item, body in pairs(Chat_prompts) do
                                if item == choice then
                                    msg = body.prompt
                                    selection = body.selection
                                    callback = body.callback
                                    break
                                end
                            end
                            -- If the choice is QuickChat or QuickChatWithFiletype, open the input dialog
                            if msg == nil then
                                local input = vim.fn.input("Quick Chat: ")
                                if input ~= "" then
                                    msg = input
                                end
                            end
                            -- If the choice is QuickChat, set the selection to nil
                            if choice == 'QuickChat' then
                                Ask_msg = msg
                                selection = function () return nil end
                            else
                                if string.find(choice, "Commit") then
                                    Ask_msg = msg
                                else
                                    Ask_msg = FiletypeMsg .. msg
                                end
                                if selection == nil then
                                    selection = opts.selection
                                    -- print("selection is nil")
                                end
                            end

                            require("CopilotChat").ask(Ask_msg,{ selection = selection, callback = callback })
                        end)
                        return true
                    end,
                }):find()
            end

            vim.api.nvim_create_user_command("CopilotActions",
                function() Telescope_CopilotActions(require("telescope.themes").get_dropdown{ selection_caret = " " }) end,
                { nargs = "*", range = true }
            )

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
                    -- require("CopilotChat.code_actions").show_prompt_actions()
                    vim.cmd("CopilotActions")
                end,
                desc = " CopilotChat - Prompt actions",
                mode = {"n","v","x"}
            },
            { '<leader>cco', "<cmd>CopilotChatOpen<cr>",        desc = " CopilotChat - Open chat",          mode = {"n", "v", "x"} },
            { '<leader>ccq', "<cmd>CopilotChatClose<cr>",       desc = " CopilotChat - Close chat",         mode = {"n", "v", "x"} },
            { '<leader>cct', "<cmd>CopilotChatToggle<cr>",      desc = " CopilotChat - Toggle chat",        mode = {"n", "v", "x"} },
            { '<leader>ccR', "<cmd>CopilotChatReset<cr>",       desc = " CopilotChat - Reset chat",         mode = {"n", "v", "x"} },
            { '<leader>ccD', "<cmd>CopilotChatDebugInfo<cr>",   desc = " CopilotChat - Show diff",          mode = {"n", "v", "x"} },

            { '<leader>cce', "<cmd>CopilotChatExplain<cr>",     desc = " CopilotChat - Explain code",       mode = {"n", "v", "x"} },
            { '<leader>ccT', "<cmd>CopilotChatFixError<cr>",    desc = " CopilotChat - Fix Error",          mode = {"n", "v", "x"} },
            { '<leader>ccr', "<cmd>CopilotChatSuggestion<cr>",  desc = " CopilotChat - Provide suggestion", mode = {"n", "v", "x"} },
            { '<leader>ccF', "<cmd>CopilotChatRefactor<cr>",    desc = " CopilotChat - Refactor code",      mode = {"n", "v", "x"} },
            { '<leader>ccA', "<cmd>CopilotChatAnnotations<cr>", desc = " CopilotChat - Add a comment",      mode = {"n", "v", "x"} },
        }
    },
}
