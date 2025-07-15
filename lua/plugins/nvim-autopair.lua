return {

    {
        'altermo/ultimate-autopair.nvim',
        -- event={'InsertEnter','CmdlineEnter'},
        event="VeryLazy",
        opts = {
            pair_map=true,
            pair_cmap=false,
            multiline=true,
            tabout = {
                enable = true,
                hopout = true,
            },
            space2={
                enable=true,
            },
            close = {  -- *ultimate-autopair-map-close-config*
                enable = true,
                map = '<A-]>', --string or table
                cmap = '<A-]>', --string or table
            },

            {'``','``',fly=true,suround=true,dosuround=true,newline=true,space=false, ft={'python'}},
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
            config_internal_pairs={
                --{'{','}',suround=true},
                {'"','"',newline=true,multiline=true},
                {"'","'",newline=true,multiline=true},
                {'```','```',newline=true,multiline=true},
            }
        },
        config = function (_, opts)
            require('ultimate-autopair').setup(opts)
        end
    },
    {
        "windwp/nvim-autopairs",
        event = { 'InsertEnter', 'CmdlineEnter' },
        -- enabled = false,
        config = function()
            require("nvim-autopairs").setup({
                fast_wrap = false,
                enable_check_bracket_line = false,
                -- map_bs = false,
                check_ts = true,
                ts_config = {
                    lua = { "string" }, -- it will not add a pair on that treesitter node
                    javascript = { "template_string" },
                    java = false, -- don't check treesitter on java
                },
            })
            ------------------------------------------------------
            -- use treesitter to check for a pair.
            local npairs = require("nvim-autopairs")
            local Rule = require("nvim-autopairs.rule")
            local ts_conds = require("nvim-autopairs.ts-conds")
            -- press % => %% only while inside a comment or string
            npairs.add_rules({
                Rule("%", "%", "lua"):with_pair(ts_conds.is_ts_node({ "string", "comment" })),
                Rule("$", "$", "lua"):with_pair(ts_conds.is_not_ts_node({ "function" })),
            })

            vim.api.nvim_create_autocmd("User", {
                pattern = "visual_multi_start",
                callback = function()
                    pcall(vim.keymap.del, "i", "<BS>", { buffer = 0 })
                end,
            })
            vim.api.nvim_create_autocmd("User", {
                pattern = "visual_multi_exit",
                callback = function()
                    require("nvim-autopairs").force_attach()
                end,
            })
            -- If you want insert `(` after select function or method item
            local cmp = require("cmp")
            local cmp_autopairs = require("nvim-autopairs.completion.cmp")
            -- local function ls_name_from_event(event)
                --     return event.entry.source.source.client.config.name
                -- end
                -- cmp.event:on('confirm_done', function(event)
                    --     local ok, ls_name = pcall(ls_name_from_event, event)
                    --     -- vim.print(ls_name)
                    --     if ok and (ls_name == 'rust-analyzer' or ls_name == 'lua_ls') then
                    --         return
                    --     end
                    --
                    --     cmp_autopairs.on_confirm_done()
                    -- end)

            local handlers = require("nvim-autopairs.completion.handlers")

            cmp.event:on(
            "confirm_done",
            cmp_autopairs.on_confirm_done({
                filetypes = {
                    -- "*" is a alias to all filetypes
                    ["*"] = {
                        ["("] = {
                            kind = {
                                cmp.lsp.CompletionItemKind.Function,
                                cmp.lsp.CompletionItemKind.Method,
                            },
                            handler = handlers["*"],
                        },
                    },
                    lua = {
                        ["("] = {
                            kind = {
                                cmp.lsp.CompletionItemKind.Function,
                                cmp.lsp.CompletionItemKind.Method,
                            },
                            ---@param char string
                            ---@param item table item completion
                            ---@param bufnr number buffer number
                            ---@param rules table
                            ---@param commit_character table<string>
                            handler = function(char, item, bufnr, rules, commit_character)
                                -- Your handler function. Inspect with print(vim.inspect{char, item, bufnr, rules, commit_character})
                            end,
                        },
                    },
                    -- Disable for tex
                    tex = false,
                },
            })
            )
        end
    }
}
