local function find_lines_between_separator(lines, pattern, at_least_one)
    local line_count            = #lines
    local separator_line_start  = 1
    local separator_line_finish = line_count
    local found_one             = false

    -- Find the last occurrence of the separator
    for i = line_count, 1, -1 do -- Reverse the loop to start from the end
        local line = lines[i]
        if string.find(line, pattern) then
            if i < (separator_line_finish + 1) and (not at_least_one or found_one) then
                separator_line_start = i + 1
                break -- Exit the loop as soon as the condition is met
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


local function commit_message_markdown(separator, result)
  -- 創建 Markdown 格式的 Commit Message 模板
  local content = {
    "# Commit Message",
    "",
    "**Changes:**",
    separator .. result .. separator,
    "",
    "**Auto commit? (y/n)**"
  }

  -- 創建一個新的 buffer
  local buf = vim.api.nvim_create_buf(false, true) -- 不列入 buffer list

  -- 設定 buffer 為 Markdown 格式
  vim.bo[buf].filetype = "markdown"

  -- 寫入內容到 buffer
  vim.api.nvim_buf_set_lines(buf, 0, -1, false, content)

  -- 設定浮動窗口大小
  local width = 60
  local height = #content + 2
  local opts = {
    relative = "editor",
    width = width,
    height = height,
    col = math.floor((vim.o.columns - width) / 2),
    row = math.floor((vim.o.lines - height) / 2),
    style = "minimal",
    border = "rounded"
  }

  -- 創建浮動窗口
  local win = vim.api.nvim_open_win(buf, true, opts)

  -- 允許用戶輸入 commit message
  vim.api.nvim_buf_set_option(buf, "modifiable", true)
  vim.api.nvim_buf_set_option(buf, "buftype", "prompt")

  -- 設定 prompt
  vim.fn.prompt_setprompt(buf, "> ")

  -- 讓用戶輸入 commit message，並處理輸入
  vim.fn.prompt_setcallback(buf, function(msg)
    vim.api.nvim_win_close(win, true) -- 關閉浮動窗口
    print("Commit Message: " .. msg)  -- 這裡可以改成 commit 操作
  end)

  vim.cmd("startinsert") -- 進入插入模式
end

-- 測試函數
-- commit_message_markdown("---", "Modified README")




local commit_callback = function(response, source, staged)
    local bufnr    = source.bufnr
    local buftype  = vim.api.nvim_get_option_value('filetype', { buf = bufnr })
    -- local notify   = vim.notify
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
    if string.match(input, '^[yY]$') then
        if string.match(buftype, 'gitcommit') then
            vim.api.nvim_input(accept)
            vim.api.nvim_input(quit)
        else
            local tmpfile = vim.fn.stdpath("cache") .. "/copilot_commit_msg"
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

            local cmd    = ""

            if not staged then
                cmd = add .. " && "
            end
            local commit_cmd = cmd .. commit .. " && " .. push

            local first_notify = notify(result, "info", {
                title = "Git committing changes in backend ...",
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
                        notify(result, "info", {
                            title = "Git commit success",
                            icon = "",
                            replace = first_notify,
                            on_open = function(win)
                                local buf = vim.api.nvim_win_get_buf(win)
                                vim.api.nvim_buf_set_option(buf, "filetype", "markdown")
                            end
                        })
                    else
                        local message = "return code:" .. code .. " signal: " .. signal
                        notify(message, "error", {
                            title = "Git commit fail",
                            icon = "",
                            replace = first_notify,
                            on_open = function(win)
                                local buf = vim.api.nvim_win_get_buf(win)
                                vim.api.nvim_buf_set_option(buf, "filetype", "markdown")
                            end
                        })
                    end
                end
            )

            vim.api.nvim_input(quit)
        end
    else
        notify("Abort", "info", { icon = "", title = "Git commit" })
        -- vim.api.nvim_input(quit)
    end
end


return {
    {
        "CopilotC-Nvim/CopilotChat.nvim",
        event = "VeryLazy",
        dependencies = {
            { "zbirenbaum/copilot.lua" },        -- or github/copilot.vim
            { "nvim-lua/plenary.nvim" },         -- for curl, log wrapper
            { "nvim-telescope/telescope.nvim" }, -- for telescope help actions (optional)
        },
        opts = {
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
            local prompts = {
                QuickChat             = {},
                Translate             = { prompt = "> /COPILOT_GENERATE\n\n將英文翻譯成繁體中文, 或是將中文翻譯成英文, 回答中不需要包含行數" },
                Commit                = {
                    prompt =
                    '使用繁體中文詳盡的總結這次提交的更改，並使用 commitizen 慣例總結提交內容，消息包涵標題以及改動的細項。確保標題最多 50 個字符，消息在 72 個字符處換行。將整個消息用 gitcommit 語言的代碼塊包裹起來。',
                    sticky = '#git:unstaged',
                    selection = false,
                    callback = function(response, source)
                        commit_callback(response, source, false)
                    end
                },
                CommitStaged          = {
                    -- prompt            = 'Write commit message for the change with commitizen convention. Make sure the title has maximum 50 characters and message is wrapped at 72 characters. Wrap the whole message in code block with language gitcommit.',
                    prompt =
                    '使用繁體中文詳盡的總結這次提交的更改，並使用 commitizen 慣例總結提交內容，消息包涵標題以及改動的細項。確保標題最多 50 個字符，消息在 72 個字符處換行。將整個消息用 gitcommit 語言的代碼塊包裹起來。',
                    sticky = '#git:staged',
                    selection = false,
                    callback = function(response, source)
                        commit_callback(response, source, true)
                    end,
                },
            }
            opts.prompts = prompts
            require("CopilotChat").setup(opts)
            vim.api.nvim_create_autocmd('BufEnter', {
                pattern = 'copilot-*',
                callback = function()
                    vim.opt_local.relativenumber = false
                    -- vim.opt_local.number         = false

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
            { '<leader>cco', "<cmd>CopilotChatOpen<cr>",        desc = "CopilotChat - Open chat",          mode = { "n", "v", "x" } },
            { '<leader>ccq', "<cmd>CopilotChatClose<cr>",       desc = "CopilotChat - Close chat",         mode = { "n", "v", "x" } },
            { '<leader>cct', "<cmd>CopilotChatToggle<cr>",      desc = "CopilotChat - Toggle chat",        mode = { "n", "v", "x" } },
            { '<leader>ccR', "<cmd>CopilotChatReset<cr>",       desc = "CopilotChat - Reset chat",         mode = { "n", "v", "x" } },
            { '<leader>ccD', "<cmd>CopilotChatDebugInfo<cr>",   desc = "CopilotChat - Show diff",          mode = { "n", "v", "x" } },

            { '<leader>cce', "<cmd>CopilotChatExplain<cr>",     desc = "CopilotChat - Explain code",       mode = { "n", "v", "x" } },
            { '<leader>ccT', "<cmd>CopilotChatFixError<cr>",    desc = "CopilotChat - Fix Error",          mode = { "n", "v", "x" } },
            { '<leader>ccr', "<cmd>CopilotChatSuggestion<cr>",  desc = "CopilotChat - Provide suggestion", mode = { "n", "v", "x" } },
            { '<leader>ccF', "<cmd>CopilotChatRefactor<cr>",    desc = "CopilotChat - Refactor code",      mode = { "n", "v", "x" } },
            { '<leader>ccA', "<cmd>CopilotChatAnnotations<cr>", desc = "CopilotChat - Add a comment",      mode = { "n", "v", "x" } },
        }
    },
}
