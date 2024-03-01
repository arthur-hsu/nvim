



-- 本地变量


local pluginKeys = {}
local luasnip = require("luasnip")
-- nvim-cmp 自动补全
pluginKeys.cmp = function(cmp)
    local feedkey = function(key, mode)
        vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes(key, true, true, true), mode, true)
    end
    local has_words_before = function()
        if vim.api.nvim_buf_get_option(0, "buftype") == "prompt" then return false end
        local line, col = unpack(vim.api.nvim_win_get_cursor(0))
        return col ~= 0 and vim.api.nvim_buf_get_text(0, line-1, 0, line-1, col, {})[1]:match("^%s*$") == nil
    end
    return {
        -- 上一个
        ["<C-p>"]  = cmp.mapping.select_prev_item(),
        ["<up>"]   = cmp.mapping.select_prev_item(),
        -- 下一个
        ["<C-n>"]  = cmp.mapping.select_next_item(),
        ["<down>"] = cmp.mapping.select_next_item(),
        -- 出现补全
        ["<C -,>"] = cmp.mapping(cmp.mapping.complete(), { "i", "c" }),
        -- 取消
        ["?"] = cmp.mapping({
            i = cmp.mapping.abort(),
            c = cmp.mapping.close(),
        }),
        
        ["<CR>"] = cmp.mapping({
            i = function(fallback)
                if cmp.visible() and cmp.get_active_entry() then
                    cmp.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = false })
                else
                    fallback()
                end
            end,
            s = cmp.mapping.confirm({ select = true }),
            c = cmp.mapping.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = true }),
        }),

        ["<S-Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_prev_item()
            elseif luasnip.jumpable(-1) then
                luasnip.jump(-1)
            else
                fallback()
            end
        end, { "i", "s" }),

        ["<Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
                -- cmp.select_next_item()
                cmp.select_next_item({ behavior = cmp.SelectBehavior.Replace })
                -- cmp.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = true })
            elseif luasnip.expand_or_jumpable() then
                luasnip.expand_or_jump()
            -- elseif has_words_before() then
            --     cmp.complete()
            else
                fallback()
            end
        end, { "i", "s" }),
        
        --["<Tab>"] = vim.schedule_wrap(
            --function(fallback)
                --if cmp.visible() and has_words_before() then
                    --cmp.select_next_item({ behavior = cmp.SelectBehavior.Select })
                --else
                    --fallback()
                --end
            --end
        --),
    }
end


return pluginKeys
