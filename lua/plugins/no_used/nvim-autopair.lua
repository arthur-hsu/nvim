return {
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

        local handlers = require('nvim-autopairs.completion.handlers')

        cmp.event:on(
            'confirm_done',
            cmp_autopairs.on_confirm_done({
                filetypes = {
                    -- "*" is a alias to all filetypes
                    ["*"] = {
                        ["("] = {
                            kind = {
                                cmp.lsp.CompletionItemKind.Function,
                                cmp.lsp.CompletionItemKind.Method,
                            },
                            handler = handlers["*"]
                        }
                    },
                    lua = {
                        ["("] = {
                            kind = {
                                cmp.lsp.CompletionItemKind.Function,
                                cmp.lsp.CompletionItemKind.Method
                            },
                            ---@param char string
                            ---@param item table item completion
                            ---@param bufnr number buffer number
                            ---@param rules table
                            ---@param commit_character table<string>
                            handler = function(char, item, bufnr, rules, commit_character)
                                -- Your handler function. Inspect with print(vim.inspect{char, item, bufnr, rules, commit_character})
                            end
                        }
                    },
                    -- Disable for tex
                    tex = false
                }
            })
        )
    end
    },
