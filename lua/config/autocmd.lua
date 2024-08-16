-- Restore cursor position
vim.api.nvim_create_autocmd({ "BufReadPost" }, {
    pattern = { "*" },
    callback = function()
        vim.api.nvim_exec('silent! normal! g`"zv', false)
    end,
})
vim.api.nvim_create_autocmd("CursorHold", {
    buffer = vim.api.nvim_get_current_buf(),
    callback = function()
        local opts = {
            focusable = false,
            close_events = { "BufLeave", "CursorMoved", "InsertEnter", "FocusLost" },
            border = 'rounded',
            source = 'always',
            prefix = ' ',
            scope = 'cursor',
        }
        vim.diagnostic.open_float(nil, opts)
    end
})
-- vim.lsp.handlers["textDocument/publishDiagnostics"] = function(_, result, ctx, _)
--   local client = vim.lsp.get_client_by_id(ctx.client_id)
--   for _, diagnostic in ipairs(result.diagnostics) do
--     print(string.format("Error Group: %s, Source: %s", diagnostic.code, client.name))
--   end
--   vim.lsp.diagnostic.on_publish_diagnostics(nil, result, ctx)
-- end
vim.api.nvim_create_autocmd('LspAttach', {
    group = vim.api.nvim_create_augroup('UserLspConfig', {}),
    callback = function(ev)
        local bufnr = ev.buf
        local client = vim.lsp.get_client_by_id(ev.data.client_id)

        vim.bo[bufnr].bufhidden = 'hide'

        -- Enable completion triggered by <c-x><c-o>
        vim.bo[bufnr].omnifunc = 'v:lua.vim.lsp.omnifunc'
        local function desc(description)
            return { noremap = true, silent = true, buffer = bufnr, desc = description }
        end

        local range_formatting = function()
            local start_row, _ = unpack(vim.api.nvim_buf_get_mark(0, "<"))
            local end_row, _ = unpack(vim.api.nvim_buf_get_mark(0, ">"))
            vim.lsp.buf.format({
                range = {
                    ["start"] = { start_row, 0 },
                    ["end"]   = { end_row, 0 },
                },
                async = true,
            })
        end

        vim.keymap.set("v", "<space>f", range_formatting, { desc = "[lsp] Range Formatting" })
        vim.keymap.set('n', '<space>f', function()
            vim.lsp.buf.format { async = true }
        end, desc('[lsp] format buffer'))

        if client.server_capabilities.inlayHintProvider then
            vim.keymap.set('n', '<space>h', function()
                -- local current_setting = vim.lsp.inlay_hint.is_enabled()
                local is_enabled = vim.lsp.inlay_hint.is_enabled({ bufnr = bufnr })
                vim.lsp.inlay_hint.enable(not is_enabled, {bufnr = bufnr})
            end, desc('[lsp] toggle inlay hints'))
        end

        -- Auto-refresh code lenses
        if not client then
            return
        end
        local function buf_refresh_codeLens()
            vim.schedule(function()
                if client.server_capabilities.codeLensProvider then
                    vim.lsp.codelens.refresh()
                    return
                end
            end)
        end
        local group = vim.api.nvim_create_augroup(string.format('lsp-%s-%s', bufnr, client.id), {})
        if client.server_capabilities.codeLensProvider then
            vim.api.nvim_create_autocmd({ 'InsertLeave', 'BufWritePost', 'TextChanged' }, {
                group = group,
                callback = buf_refresh_codeLens,
                buffer = bufnr,
            })
            buf_refresh_codeLens()
        end
    end,
})
