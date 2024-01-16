return {
    'altermo/ultimate-autopair.nvim',
    -- enabled = false,
    event={'InsertEnter','CmdlineEnter'},
    -- event="VeryLazy",
    branch='development',
    config = function ()
        require('ultimate-autopair').setup({
            -- multi=false,
            tabout={enable=true},

            -- internal_pairs={-- *ultimate-autopair-pairs-default-pairs*
            --     {'[',']',fly=true,dosuround=true,newline=true,space=true},
            --     {'(',')',fly=true,dosuround=true,newline=true,space=true},
            --     {'{','}',fly=true,dosuround=true,newline=true,space=true},
            --     {'"','"',suround=true,multiline=false,alpha={'txt'}},
            --     {"'","'",suround=true,cond=function(fn) return not fn.in_lisp() or fn.in_string() end,alpha=true,nft={'tex','latex'},multiline=false},
            --     {'`','`',nft={'tex','latex'},multiline=false},
            --     {'``',"''",ft={'tex','latex'}},
            --     {'```','```',newline=true,ft={'markdown'}},
            --     {'<!--','-->',ft={'markdown','html'}},
            --     {'"""','"""',newline=true,ft={'python'}},
            --     {"'''","'''",newline=true,ft={'python'}},
            -- },
            config_internal_pairs={
                {'`','`',suround=true,cond=function(fn) return not fn.in_lisp() or fn.in_string() end,alpha=true,nft={'tex','latex'},multiline=false},
            }
        })
        local function ls_name_from_event(event)
            return event.entry.source.source.client.config.name
        end
        local cmp=require('cmp')
        local Kind=cmp.lsp.CompletionItemKind
        -- Add parenthesis on completion confirmation
        cmp.event:on(
            'confirm_done',
            function(event)
            local ok, ls_name = pcall(ls_name_from_event, event)
            if ok and (ls_name == 'rust_analyzer' or ls_name == 'lua_ls') then
                return
            end

            local completion_kind = event.entry:get_completion_item().kind
            if vim.tbl_contains({ Kind.Function, Kind.Method }, completion_kind) then
                local left = vim.api.nvim_replace_termcodes('<Left>', true, true, true)
                vim.api.nvim_feedkeys('()' .. left, 'n', false)
            end
        end)

    end
}
