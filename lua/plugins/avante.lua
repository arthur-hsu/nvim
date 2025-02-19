vim.api.nvim_set_hl(0, "AvanteIncoming", { bg = "#304753" })
return {
    "yetone/avante.nvim",
    event = "VeryLazy",
    version = false,
    -- tag = "v0.0.13",
    opts = {
        ---@alias Provider "claude" | "openai" | "azure" | "gemini" | "cohere" | "copilot" | string
        provider = "copilot",           -- Recommend using Claude
        auto_suggestions_provider = "claude", -- Since auto-suggestions are a high-frequency operation and therefore expensive, it is recommended to specify an inexpensive provider or even a free provider: copilot
        claude = {
            endpoint = "https://api.anthropic.com",
            model = "claude-3-5-sonnet-20241022",
            temperature = 0,
            max_tokens = 4096,
        },
        highlights = {
            ---@type AvanteConflictHighlights
            diff = {
                current = "RenderMarkdownCode",
                incoming = "AvanteIncoming",
            },
        },
        behaviour = {
            auto_focus_sidebar               = true,
            auto_suggestions                 = false, -- Experimental stage
            auto_suggestions_respect_ignore  = false,
            auto_set_highlight_group         = true,
            auto_set_keymaps                 = true,
            auto_apply_diff_after_generation = true,
            jump_result_buffer_on_finish     = false,
            support_paste_from_clipboard     = false,
            minimize_diff                    = true,
            enable_token_counting            = true,
            enable_cursor_planning_mode      = false,
        },
    },
    build = vim.fn.has("win32") == 1 and "powershell -ExecutionPolicy Bypass -File Build.ps1 -BuildFromSource false" or "make",
    dependencies = {
        "stevearc/dressing.nvim",
        "nvim-lua/plenary.nvim",
        "MunifTanjim/nui.nvim",
        --- The below dependencies are optional,
        "hrsh7th/nvim-cmp",      -- autocompletion for avante commands and mentions
        "nvim-tree/nvim-web-devicons", -- or echasnovski/mini.icons
        "zbirenbaum/copilot.lua", -- for providers='copilot'
        {
            -- support for image pasting
            "HakonHarnes/img-clip.nvim",
            event = "VeryLazy",
            opts = {
                -- recommended settings
                default = {
                    embed_image_as_base64 = false,
                    prompt_for_file_name = false,
                    drag_and_drop = {
                        insert_mode = true,
                    },
                    -- required for Windows users
                    use_absolute_path = true,
                },
            },
        },
    },
}
