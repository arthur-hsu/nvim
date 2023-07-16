local M = {
    'ray-x/lsp_signature.nvim',
    lazy = false,
    -- enabled =true,
    event="InsertEnter",
}


function M.config()
    require "lsp_signature".setup({
        bind = true, -- This is mandatory, otherwise border config won't get registered.
        hint_enable = true, -- 启用虚拟提示
        hint_prefix = "",  -- Panda for parameter, NOTE: for the terminal not support emoji, might crash
        hi_parameter = "LspSignatureActiveParameter", -- 你的参数将如何被突出显示
        warp = false,
        floating_window = true,
        floating_window_above_cur_line = true,
        check_completion_visible = true,
        handler_opts = {
            border = "rounded"
        }
    })

end
return M

