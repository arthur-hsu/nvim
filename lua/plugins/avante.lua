vim.api.nvim_set_hl(0, "AvanteIncoming", { bg = "#304753" })
return {
    "yetone/avante.nvim",
    event = "VeryLazy",
    version = "*", -- set this to "*" if you want to always pull the latest change, false to update on release
    opts = {
        ---@alias Provider "claude" | "openai" | "azure" | "gemini" | "cohere" | "copilot" | string
        provider = "copilot",                  -- Recommend using Claude
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
            auto_suggestions = false, -- Experimental stage
            auto_set_highlight_group = true,
            auto_set_keymaps = true,
            auto_apply_diff_after_generation = false,
            support_paste_from_clipboard = true,
            minimize_diff = true, -- Whether to remove unchanged lines when applying a code block
        },
    },
    -- if you want to build from source then do `make BUILD_FROM_SOURCE=true`
    build = function()
        local platform = vim.loop.os_uname().sysname
        if platform == "Windows_NT" then
            return "powershell -ExecutionPolicy Bypass -File Build.ps1 -BuildFromSource false"
        else
            return "make"
        end
    end,
    dependencies = {
        "stevearc/dressing.nvim",
        "nvim-lua/plenary.nvim",
        "MunifTanjim/nui.nvim",
        --- The below dependencies are optional,
        "hrsh7th/nvim-cmp",            -- autocompletion for avante commands and mentions
        "nvim-tree/nvim-web-devicons", -- or echasnovski/mini.icons
        "zbirenbaum/copilot.lua",      -- for providers='copilot'
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
