-- Restore cursor position
vim.api.nvim_create_autocmd({ "BufReadPost" }, {
    pattern = { "*" },
    callback = function()
        vim.api.nvim_exec('silent! normal! g`"zv', false)
    end,
})
-- vim.api.nvim_create_autocmd("CursorHold", {
--     buffer = vim.api.nvim_get_current_buf(),
--     callback = function()
--         local opts = {
--             focusable = false,
--             close_events = { "BufLeave", "CursorMoved", "InsertEnter", "FocusLost" },
--             border = 'rounded',
--             source = 'always',
--             prefix = ' ',
--             scope = 'cursor',
--         }
--         vim.diagnostic.open_float(nil, opts)
--     end
-- })
