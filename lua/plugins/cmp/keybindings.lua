local pluginKeys = {}
local luasnip = require("luasnip")
-- nvim-cmp 自动补全
pluginKeys.keybind = function(cmp)
    local feedkey = function(key, mode)
        vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes(key, true, true, true), mode, true)
    end
    local has_words_before = function()
        if vim.api.nvim_buf_get_option(0, "buftype") == "prompt" then return false end
        local line, col = unpack(vim.api.nvim_win_get_cursor(0))
        return col ~= 0 and vim.api.nvim_buf_get_text(0, line-1, 0, line-1, col, {})[1]:match("^%s*$") == nil
    end
    return {
        -- -- 上一个
        -- ["<up>"]   = cmp.mapping.select_prev_item(),
        -- -- 下一个
        -- ["<down>"] = cmp.mapping.select_next_item(),

        ["<up>"] = cmp.mapping(function(fallback)
            if cmp.visible() and has_words_before() then
                cmp.select_prev_item({ behavior = cmp.SelectBehavior.Replace })
            else
                fallback()
            end
        end, { "i", "s" }),

        ["<down>"] = cmp.mapping(function(fallback)
            if cmp.visible() and has_words_before() then
                cmp.select_next_item({ behavior = cmp.SelectBehavior.Replace })
            else
                fallback()
            end
        end, { "i", "s" }),





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
            s = cmp.mapping.confirm({ select = false }),
            c = cmp.mapping.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = false }),
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
            if cmp.visible() and has_words_before() then
                cmp.select_next_item({ behavior = cmp.SelectBehavior.Replace })
                -- if #cmp.get_entries() == 1 then
                --     cmp.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = true })
                -- else
                --     cmp.select_next_item({ behavior = cmp.SelectBehavior.Replace })
                -- end
            elseif has_words_before() then
                if cmp.visible() then
                    cmp.complete()
                    if #cmp.get_entries() == 1 then
                        cmp.confirm({ select = true })
                    end
                else
                    fallback()
                end
            elseif luasnip.expand_or_jumpable() then
                luasnip.expand_or_jump()
            else
                fallback()
            end
        end, { "i", "s" }),

        -- -- cmd line mapping
        -- ['<Tab>'] = {
        --     c = function(_)
        --         if cmp.visible() then
        --             if #cmp.get_entries() == 1 then
        --                 cmp.confirm({ select = true })
        --             else
        --                 cmp.select_next_item()
        --             end
        --         else
        --             cmp.complete()
        --             if #cmp.get_entries() == 1 then
        --                 cmp.confirm({ select = true })
        --             end
        --         end
        --     end,
        -- }



        -- -- Raw tab
        -- ["<Tab>"] = cmp.mapping(function(fallback)
        --     if cmp.visible() and has_words_before() then
        --         cmp.select_next_item({ behavior = cmp.SelectBehavior.Replace })
        --         -- cmp.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = true })
        --     elseif luasnip.expand_or_jumpable() then
        --         luasnip.expand_or_jump()
        --     else
        --         fallback()
        --     end
        -- end, { "i", "s" }),



        -- -- Copilot cmp recommend
        -- ["<Tab>"] = vim.schedule_wrap(
        --     function(fallback)
        --         if cmp.visible() and has_words_before() then
        --             cmp.select_next_item({ behavior = cmp.SelectBehavior.Select })
        --         else
        --             fallback()
        --         end
        --     end
        -- ),
    }
end


return pluginKeys
