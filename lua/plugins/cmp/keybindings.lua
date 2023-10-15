local has_words_before = function()
    unpack = unpack or table.unpack
    local line, col = unpack(vim.api.nvim_win_get_cursor(0))
    return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end
local luasnip = require("luasnip")



local opt = {
    noremap = true,
    silent = true,
}

-- 本地变量
local map = vim.api.nvim_set_keymap

local pluginKeys = {}

-- Global mappings.
-- See `:help vim.diagnostic.*` for documentation on any of the below functions
vim.keymap.set('n', '<space>e', vim.diagnostic.open_float)
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next)
vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist)

-- Use LspAttach autocommand to only map the following keys
-- after the language server attaches to the current buffer
vim.api.nvim_create_autocmd('LspAttach', {
    group = vim.api.nvim_create_augroup('UserLspConfig', {}),
    callback = function(ev)
        -- Enable completion triggered by <c-x><c-o>
        vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'

        local opts = { buffer = ev.buf }
        -- Buffer local mappings.

        vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
        vim.keymap.set('n', 'gpd', "<CMD>Lspsaga peek_definition<CR>", opts)
        vim.keymap.set('n', 'gh', vim.lsp.buf.hover, opts)
        vim.keymap.set('n', 'gH', vim.lsp.buf.signature_help, opts)
        vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
        vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, opts)
        vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, opts)
        vim.keymap.set('n', '<space>wl', function() print(vim.inspect(vim.lsp.buf.list_workspace_folders())) end, opts)
        vim.keymap.set('n', '<space>rn', "<CMD>lua vim.lsp.buf.rename()<CR>", opts)
        --vim.keymap.set('n', '<space>rn', "<CMD>Lspsaga rename<CR>", opts)
        vim.keymap.set('n', '<space>sw', "<CMD>Lspsaga outline<CR>", opts)
        vim.keymap.set('n', '<space>sf', "<CMD>Lspsaga finder<CR>", opts)
        vim.keymap.set({ 'n', 'v' }, '<SPACE>ca', "<CMD>Lspsaga code_action<CR>", opts)
        vim.keymap.set('n', '<space>f', function() vim.lsp.buf.format { async = true } end, opts)
        -- See `:help vim.lsp.*` for documentation on any of the below functions
    end,
})


-- nvim-cmp 自动补全
pluginKeys.cmp = function(cmp)
    local feedkey = function(key, mode)
        vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes(key, true, true, true), mode, true)
    end
    local has_words_before = function()
        local line, col = unpack(vim.api.nvim_win_get_cursor(0))
        return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
    end

    return {
        -- 上一个
        ["<C-p>"] = cmp.mapping.select_prev_item(),
        ["<up>"] = cmp.mapping.select_prev_item(),
        -- 下一个
        ["<C-n>"] = cmp.mapping.select_next_item(),
        ["<down>"] = cmp.mapping.select_next_item(),
        -- 出现补全
        ["<A-.>"] = cmp.mapping(cmp.mapping.complete(), { "i", "c" }),
        -- 取消
        ["/"] = cmp.mapping({
            i = cmp.mapping.abort(),
            c = cmp.mapping.close(),
        }),
        ['<CR>'] = cmp.mapping.confirm {
            behavior = cmp.ConfirmBehavior.Replace,
            select = true,
        },
        ["<Tab>"] = cmp.mapping(
            function(fallback)
                local copilot = require 'copilot.suggestion'
                if copilot.is_visible() then
                    copilot.accept()
                elseif cmp.visible() then
                    cmp.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = true })
                elseif luasnip.expand_or_jumpable() then
                    luasnip.expand_or_jump()
                elseif has_words_before() then
                    cmp.complete()
                else
                    fallback()
                end
            end, { "i", "s" }
        ),
    }
end


return pluginKeys
