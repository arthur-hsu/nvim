return{
    {
        'https://github.com/github/copilot.vim',
        event = { "BufReadPost", "BufNewFile" },
        enabled=false,
        config = function ()
            vim.cmd [[imap <silent><script><expr> <C-a> copilot#Accept("\<CR>")]]
            vim.g.copilot_no_tab_map = true
            vim.cmd[[highlight CopilotSuggestion guifg=#96ff00 guibg=#162a33 ctermfg=8]]
        end,
    },
    {
        "https://github.com/zbirenbaum/copilot.lua",
        cmd = "Copilot",
        event = { "BufReadPost", "BufNewFile" },
        --event = "InsertEnter",
        config = function()
            require("copilot").setup({
                panel = {
                    enabled = false,
                    auto_refresh = true,
                    keymap = {
                        jump_prev = "[[",
                        jump_next = "]]",
                        accept = "<CR>",
                        refresh = "gr",
                        open = "<M-CR>"
                    },
                    layout = {
                        position = "bottom", -- | top | left | right
                        ratio = 0.4
                    },
                },
                suggestion = {
                    enabled = false,
                    auto_trigger = true,
                    debounce = 75,
                    keymap = {
                        accept = false, --"<C-a>",
                        accept_word = false,
                        accept_line = false,
                        next = "<M-]>",
                        prev = "<M-[>",
                        dismiss = "/",
                    },
                },
                filetypes = {
                    yaml = false,
                    markdown = true,
                    help = false,
                    gitcommit = false,
                    gitrebase = false,
                    hgcommit = false,
                    svn = false,
                    cvs = false,
                    ["."] = false,
                },
                copilot_node_command = 'node', -- Node.js version must be > 16.x
                server_opts_overrides = {
                    trace = "verbose",
                    settings = {
                        advanced = {
                            listCount = 10, -- #completions for panel
                            inlineSuggestCount = 3, -- #completions for getCompletions
                        }
                    },
                }
            })
            --local cmp = require 'cmp'
            --local copilot = require 'copilot.suggestion'
            --local luasnip = require 'luasnip'
            --local function set_trigger(trigger)
                --vim.b.copilot_suggestion_auto_trigger = trigger
                --vim.b.copilot_suggestion_hidden = not trigger
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
            --end)
            --vim.api.nvim_create_autocmd('User', {
                --pattern = { 'LuasnipInsertNodeEnter', 'LuasnipInsertNodeLeave' },
                --callback = function()
                    --set_trigger(not luasnip.expand_or_locally_jumpable())
                --end,
            --})
        end,
    },
    {
        "https://github.com/zbirenbaum/copilot-cmp",
        event = { "InsertEnter", "LspAttach" },
        --fix_pairs = true,
        config = function ()
            require("copilot_cmp").setup()
        end
    },

}
