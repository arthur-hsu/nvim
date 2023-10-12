return{
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
    {
        "zbirenbaum/copilot.lua",
        cmd = "Copilot",
        event = { "BufReadPost", "BufNewFile" },
        --event = "InsertEnter",
        config = function()
            require("copilot").setup({
                panel = {
                    enabled = true,
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
                    enabled = true,
                    auto_trigger = true,
                    debounce = 75,
                    keymap = {
                        accept = "<C-a>",
                        accept_word = false,
                        accept_line = false,
                        next = "<M-]>",
                        prev = "<M-[>",
                        dismiss = "<C-e>",
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
        end,
    }
}
