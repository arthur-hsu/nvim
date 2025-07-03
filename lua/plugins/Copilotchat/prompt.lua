local func = require("plugins.Copilotchat.func")
local function CommitMsg(staged)
    return {
        -- prompt = "使用繁體中文詳盡的總結這次提交的更改，並使用 commitizen 慣例總結提交內容，消息包涵標題以及改動的細項。確保標題最多 50 個字符，消息在 72 個字符處換行。將整個消息用 gitcommit 語言的代碼塊包裹起來。",
        prompt = 'Write commit message for the change with commitizen convention. Keep the title under 50 characters and wrap message at 72 characters. Format as a gitcommit code block.',

        context = staged and 'git:staged' or 'git:unstaged',
        selection = false,
        model = "gpt-4o",
        debug = true,
        window = {
            layout = 'float',
            relative = 'win',
            row = -1, -- row position of the window, default is centered
            col = 100000, -- column position of the window, default is centered
            width = 0.4,
            height = 0.4,
            title = "  Auto Commit",
        },
        callback = function(response, source)
            func.commit_callback(response, source, false)
        end
    }
end



return {
    Translate             = { prompt = "> /COPILOT_GENERATE\n\n將英文翻譯成繁體中文, 或是將中文翻譯成英文, 回答中不需要包含行數" },
    Commit                = CommitMsg(false),
    CommitStaged          = CommitMsg(true),
}

