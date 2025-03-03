return {
    {
        "zbirenbaum/copilot.lua",
        cmd = "Copilot",
        event = "VeryLazy",
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
        end,
    },
    {
        "zbirenbaum/copilot-cmp",
        -- event = { "InsertEnter", "LspAttach" },
        event = "VeryLazy",

        config = function ()
            require("copilot_cmp").setup({
                fix_pairs = true
            })
        end
    }
}
