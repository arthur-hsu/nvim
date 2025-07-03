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

local commit_callback = function(response, source, staged)
    local bufnr    = source.bufnr
    local buftype  = vim.api.nvim_get_option_value('filetype', { buf = bufnr })
    -- local notify   = vim.notify
    local notify   = require("notify")
    local accept   = require("CopilotChat").config.mappings.accept_diff.normal
    -- local quit     = require("CopilotChat").config.mappings.close.normal
    local quit     = "CopilotChatClose"
    local showdiff = require("CopilotChat").config.mappings.show_diff.normal
    local chat = require("CopilotChat")
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
        if chat.chat:visible() then
            vim.cmd(quit)
        end
        return
    end
    local separator = "\n" .. string.rep("─", max_line) .. "\n"
    local input = vim.fn.input("Commit message" .. separator .. result .. separator .. "auto commit? (y/n)")
    if string.match(input, '^[yY]$') then
        if string.match(buftype, 'gitcommit') then
            vim.api.nvim_input(accept)
            if chat.chat:visible() then
                vim.cmd(quit)
            end
        else
            if chat.chat:visible() then
                vim.cmd(quit)
            end
            local tmpfile = vim.fn.stdpath("cache") .. "/copilot_commit_msg"
            local file = io.open(tmpfile, "w")
            if not file then
                notify("Failed to open file: " .. tmpfile, "error", { title = "Git commit" })
                if chat.chat:visible() then
                    vim.cmd(quit)
                end
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
                icon = "",
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
                            icon = "",
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
                            icon = "",
                            replace = first_notify,
                            on_open = function(win)
                                local buf = vim.api.nvim_win_get_buf(win)
                                vim.api.nvim_buf_set_option(buf, "filetype", "markdown")
                            end
                        })
                    end
                end
            )

        end
    else
        notify("Abort", "info", { icon = "", title = "Git commit" })
        if chat.chat:visible() then
            vim.cmd(quit)
        end
    end
end

return {
    find_lines_between_separator = find_lines_between_separator,
    commit_callback = commit_callback
}

