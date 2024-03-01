return{
    {
        "kylechui/nvim-surround",
        version = "*", -- Use for stability; omit to use `main` branch for the latest features
        event = "VeryLazy",
        config = function()
            require("nvim-surround").setup()
        end
    },
    {
        'altermo/ultimate-autopair.nvim',
        event={'InsertEnter','CmdlineEnter'},
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
                -- vim.print(ls_name)

                if ok and (ls_name == 'rust-analyzer' or ls_name == 'lua_ls') then
                    return
                end

                local completion_kind = event.entry:get_completion_item().kind
                if vim.tbl_contains({ Kind.Function, Kind.Method }, completion_kind) then
                    local left = vim.api.nvim_replace_termcodes('<Left>', true, true, true)
                    vim.api.nvim_feedkeys('()' .. left, 'n', false)
                end
            end)

        end
    },
    {
        "windwp/nvim-autopairs",
        event   = 'VeryLazy',
        enabled = false,
        config = function ()
            require('nvim-autopairs').setup({
                fast_wrap = {},
                enable_check_bracket_line = false,
                -- map_bs = false,
                check_ts = true,
                ts_config = {
                    lua = {'string'},-- it will not add a pair on that treesitter node
                    javascript = {'template_string'},
                    java = false,-- don't check treesitter on java
                }
            })
            ------------------------------------------------------
            -- use treesitter to check for a pair.
            local npairs = require("nvim-autopairs")
            local Rule = require('nvim-autopairs.rule')
            local ts_conds = require('nvim-autopairs.ts-conds')
            -- press % => %% only while inside a comment or string
            npairs.add_rules({
                Rule("%", "%", "lua")
                :with_pair(ts_conds.is_ts_node({'string','comment'})),
                Rule("$", "$", "lua")
                :with_pair(ts_conds.is_not_ts_node({'function'}))
            })
            local cmp = require("cmp")
            -- If you want insert `(` after select function or method item
            local cmp_autopairs = require('nvim-autopairs.completion.cmp')
            cmp.event:on('confirm_done',cmp_autopairs.on_confirm_done())
        end
    }
}
