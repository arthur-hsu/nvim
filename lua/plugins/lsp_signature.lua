local M = {
    'ray-x/lsp_signature.nvim',
    lazy = false,
    --enabled = false,
    event="InsertEnter",
}


function M.config()
    require "lsp_signature".setup({
        bind = true, -- This is mandatory, otherwise border config won't get registered.
        hint_enable = false, -- 启用虚拟提示
        hint_prefix = "",  -- Panda for parameter, NOTE: for the terminal not support emoji, might crash
        noice = true,
        padding = '|',
        hi_parameter = "LspSignatureActiveParameter", -- 你的参数将如何被突出显示
        warp = false,
        floating_window = true,
        close_timeout = 100,
        floating_window_above_cur_line = true,
        check_completion_visible = true,
        handler_opts = {
            border = "rounded"
        },
        floating_window_off_x = 5, -- adjust float windows x position.
        floating_window_off_y = function() -- adjust float windows y position. e.g. set to -2 can make floating window move up 2 lines
            local linenr = vim.api.nvim_win_get_cursor(0)[1] -- buf line number
            local pumheight = vim.o.pumheight
            local winline = vim.fn.winline() -- line number in the window
            local winheight = vim.fn.winheight(0)

            -- window top
            if winline - 1 < pumheight then
                  return pumheight
            end

            -- window bottom
            if winheight - winline < pumheight then
                  return -pumheight
            end
            return 0
        end,

    })

end
return M

