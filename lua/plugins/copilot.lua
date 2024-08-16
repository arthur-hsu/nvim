return{
    {
        "zbirenbaum/copilot.lua",
        cmd = "Copilot",
        -- event = { "BufReadPost", "BufNewFile" },
        event = "InsertEnter",
        config = function()
            require("copilot").setup({
                panel = {
                    enabled      = true,
                    auto_refresh = true,
                    keymap = {
                        jump_prev = "[[",
                        jump_next = "]]",
                        accept    = "<CR>",
                        refresh   = "gr",
                        open      = "<M-CR>"
                    },
                    layout = {
                        position = "bottom", -- | top | left | right
                        ratio    = 0.4
                    },
                },
                suggestion = {
                    enabled      = false,
                    auto_trigger = true,
                    debounce     = 75,
                    keymap = {
                        accept      = false, --"<C-a>",
                        accept_word = false,
                        accept_line = false,
                        next        = "<M-]>",
                        prev        = "<M-[>",
                        dismiss     = "/",
                    },
                },
                filetypes = {
                    ['*'] = true,
                    -- yaml      = true,
                    -- markdown  = true,
                    -- help      = false,
                    -- gitcommit = true,
                    -- gitrebase = false,
                    -- hgcommit  = false,
                    -- svn       = false,
                    -- cvs       = false,
                    -- ["."]     = true,
                },
                copilot_node_command = 'node', -- Node.js version must be > 16.x
                server_opts_overrides = {
                    trace = "verbose",
                    settings = {
                        advanced = {
                            listCount          = 10, -- #completions for panel
                            inlineSuggestCount = 3, -- #completions for getCompletions
                        }
                    },
                }
            })
            -- -- auto_trigger
            -- local cmp = require 'cmp'
            -- cmp.event:on("menu_opened", function()
            --     vim.b.copilot_suggestion_hidden = true
            -- end)
            --
            -- cmp.event:on("menu_closed", function()
            --     vim.b.copilot_suggestion_hidden = false
            -- end)





            --local copilot = require 'copilot.suggestion'
            --local luasnip = require 'luasnip'
            --local function set_trigger(trigger)
                --vim.b.copilot_suggestion_auto_trigger = trigger
                --vim.b.copilot_suggestion_hidden       = not trigger
            --end

            -- Hide suggestions when the completion menu is open.
            --cmp.event:on('menu_opened', function()
                --if copilot.is_visible() then
                    --copilot.dismiss()
                --end
                --set_trigger(false)
            --end)

            -- Disable suggestions when inside a snippet.
            --cmp.event:on('menu_closed', function()
                --set_trigger(not luasnip.expand_or_locally_jumpable())
            --end
            --vim.api.nvim_create_autocmd('User', {
                --pattern = { 'LuasnipInsertNodeEnter', 'LuasnipInsertNodeLeave' },
                --callback = function()
                    --set_trigger(not luasnip.expand_or_locally_jumpable())
                --end,
            --})
        end,
    },
    {
        "zbirenbaum/copilot-cmp",
        event = { "InsertEnter", "LspAttach" },

        config = function ()
            require("copilot_cmp").setup({
                fix_pairs = true
            })
        end
    },
    {
        'github/copilot.vim',
        event = { "BufReadPost", "BufNewFile" },
        enabled=false,
        config = function ()
            vim.cmd [[imap <silent><script><expr> <C-a> copilot#Accept("\<CR>")]]
            vim.g.copilot_no_tab_map = true
            vim.cmd[[highlight CopilotSuggestion guifg=#96ff00 guibg=#162a33 ctermfg=8]]
        end,
    },

}
