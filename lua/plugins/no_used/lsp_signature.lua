

local return_y = function()
    local linenr    = vim.api.nvim_win_get_cursor(0)[1] -- buf line number
    local pumheight = vim.o.pumheight
    local winline   = vim.fn.winline() -- line number in the window
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
end






return {
    'ray-x/lsp_signature.nvim',
    event = { "BufReadPost", "BufNewFile" },

    enabled = false,
    opts = {
        debug     = false,                                           -- set to true to enable debug logging
        log_path  = vim.fn.stdpath("cache") .. "/lsp_signature.log", -- log dir when debug is on default is  ~/.cache/nvim/lsp_signature.log
        verbose   = true,                                           -- show debug line number
        bind      = false,                                            -- This is mandatory, otherwise border config won't get registered. If you want to hook lspsaga or other signature handler, pls set to false
        doc_lines = 12,                                              -- will show two lines of comment/doc(if there are more than two lines in doc, will be truncated);
                                                                     -- set to 0 if you DO NOT want any API comments be shown
                                                                     -- This setting only take effect in insert mode, it does not affect signature help in normal
                                                                     -- mode, 10 by default

        max_height                     = 12,                         -- max height of signature floating_window
        max_width                      = 80,                         -- max_width of signature floating_window, line will be wrapped if exceed max_width the value need >= 40
        wrap                           = true,                       -- allow doc/signature text wrap inside floating_window, useful if your lsp return doc/sig is too long
        floating_window                = true,                       -- show hint in a floating window, set to false for virtual text only mode
        floating_window_above_cur_line = true,                       -- try to place the floating above the current line when possible Note:
                                                                     -- will set to true when fully tested, set to false will use whichever side has more space
                                                                     -- this setting will be helpful if you do not want the PUM and floating win overlap

        close_timeout = 1000,                                        -- close floating window after ms when laster parameter is entered
        hint_enable = false,                          -- virtual hint enable
    },
    config = function(_, opts)
        require'lsp_signature'.setup(opts)

        vim.keymap.set( { 'n' }, '<C-k>',
            function()
                require('lsp_signature').toggle_float_win()
            end,
            { silent = true, noremap = true, desc = 'toggle signature' }
        )
        vim.keymap.set( { 'n' }, '<Leader>k',
            function()
                vim.lsp.buf.signature_help()
            end,
            { silent = true, noremap = true, desc = 'toggle signature' }
        )
    end
}
