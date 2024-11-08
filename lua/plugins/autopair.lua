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
        -- event={'InsertEnter','CmdlineEnter'},
        event="VeryLazy",
        dependencies = {'junegunn/vim-easy-align'},
        branch='development',
        -- branch='v0.6',
        -- enabled=false,
        config = function ()
            require('ultimate-autopair').setup({
                pair_cmap=false,
                tabout = {
                    enable = true,
                    hopout = true,
                },

                internal_pairs={-- *ultimate-autopair-pairs-default-pairs*
                    {'[',']',fly=true,dosuround=true,newline=true,space=true},
                    {'(',')',fly=true,dosuround=true,newline=true,space=true},
                    {'{','}',fly=true,dosuround=true,newline=true,space=true},
                    {'"','"',suround=true,multiline=false},
                    {"'","'",suround=true,cond=function(fn) return not fn.in_lisp() or fn.in_string() end,alpha=true,nft={'tex'},multiline=false},
                    {'`','`',cond=function(fn) return not fn.in_lisp() or fn.in_string() end,nft={'tex'},multiline=false},
                    {'``',"''",ft={'tex'}},
                    {'```','```',newline=true,ft={'markdown'}},
                    {'<!--','-->',ft={'markdown','html'},space=true},
                    {'"""','"""',newline=true,ft={'python'}},
                    {"'''","'''",newline=true,ft={'python'}},
                },
                {'``','``',fly=true,dosuround=true,newline=true,space=false, ft={'python'}},
            })

            local function ls_name_from_event(event) return event.entry.source.source.client.config.name end
            local cmp=require('cmp')
            local Kind=cmp.lsp.CompletionItemKind
            -- Add parenthesis on completion confirmation
            cmp.event:on(
                'confirm_done',
                function(event)
                    local ok, ls_name = pcall(ls_name_from_event, event)
                    if ok and (ls_name == 'rust-analyzer' or ls_name == 'lua_ls') then
                        return
                    end

                    local completion_kind = event.entry:get_completion_item().kind
                    if vim.tbl_contains({ Kind.Function, Kind.Method }, completion_kind) then
                        local left = vim.api.nvim_replace_termcodes('<Left>', true, true, true)
                        vim.api.nvim_feedkeys('()' .. left, 'n', false)
                    end
                end
            )
        end
    },
    {
        "windwp/nvim-autopairs",
        event={'InsertEnter','CmdlineEnter'},
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
            local npairs   = require("nvim-autopairs")
            local Rule     = require('nvim-autopairs.rule')
            local ts_conds = require('nvim-autopairs.ts-conds')
            -- press % => %% only while inside a comment or string
            npairs.add_rules({
                Rule("%", "%", "lua")
                :with_pair(ts_conds.is_ts_node({'string','comment'})),
                Rule("$", "$", "lua")
                :with_pair(ts_conds.is_not_ts_node({'function'}))
            })
            -- If you want insert `(` after select function or method item
            local cmp = require("cmp")
            local cmp_autopairs = require('nvim-autopairs.completion.cmp')
            local function ls_name_from_event(event)
                return event.entry.source.source.client.config.name
            end
            cmp.event:on('confirm_done', function(event)
                local ok, ls_name = pcall(ls_name_from_event, event)
                -- vim.print(ls_name)

                cmp_autopairs.on_confirm_done()
                if ok and (ls_name == 'rust-analyzer' or ls_name == 'lua_ls') then
                    return
                end
            end)
        end
    }
}
