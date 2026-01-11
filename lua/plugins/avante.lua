vim.api.nvim_set_hl(0, "AvanteIncoming", { bg = "#304753" })
return {
	"yetone/avante.nvim",
	dependencies = {
		"stevearc/dressing.nvim",
		"nvim-lua/plenary.nvim",
		"MunifTanjim/nui.nvim",
		--- The below dependencies are optional,
		"hrsh7th/nvim-cmp", -- autocompletion for avante commands and mentions
		"nvim-tree/nvim-web-devicons", -- or echasnovski/mini.icons
		"zbirenbaum/copilot.lua", -- for providers='copilot'
		-- {
		-- 	-- support for image pasting
		-- 	"HakonHarnes/img-clip.nvim",
		-- 	event = "VeryLazy",
		-- 	opts = {
		-- 		-- recommended settings
		-- 		default = {
		-- 			embed_image_as_base64 = false,
		-- 			prompt_for_file_name = false,
		-- 			drag_and_drop = {
		-- 				insert_mode = true,
		-- 			},
		-- 			-- required for Windows users
		-- 			use_absolute_path = true,
		-- 		},
		-- 	},
		-- },
	},
	event = "VeryLazy",
	version = false,
    -- commit = "4e75d03",

	-- tag = "v0.0.13",
	build = vim.fn.has("win32") == 1 and "powershell -ExecutionPolicy Bypass -File Build.ps1 -BuildFromSource false" or "make",
	opts = {
        -- debug = true,
		---@alias Provider "claude" | "openai" | "azure" | "gemini" | "cohere" | "copilot" | string
		provider                  = "gemini-cli",
		auto_suggestions_provider = "copilot", -- Since auto-suggestions are a high-frequency operation and therefore expensive, it is recommended to specify an inexpensive provider or even a free provider: copilot
        -- acp_providers             = {
        --     ["gemini-cli"] = {
        --         command = "gemini",
        --         args = {
        --             "--experimental-acp",
        --             "--allowed-tools=ShellTool",
        --             -- "-m gemini-2.5-flash",
        --         },
        --     },
        -- },
        providers = {
            copilot = {
                model = "claude-sonnet-4",
            },
            gemini = {
                model = "gemini-3-flash-preview",
            }
        },
		highlights = {
			diff = {
				current = "RenderMarkdownCode",
				incoming = "AvanteIncoming",
			},
		},
        behaviour = {
            auto_focus_sidebar = true,
            auto_suggestions = false, -- Experimental stage
            auto_apply_diff_after_generation = false,
            jump_result_buffer_on_finish = false,
            support_paste_from_clipboard = false,
            minimize_diff = true,
            enable_token_counting = false,
            use_cwd_as_project_root = false,
            auto_focus_on_diff_view = false,
            ---@type boolean | string[] -- true: auto-approve all tools, false: normal prompts, string[]: auto-approve specific tools by name
            auto_approve_tool_permissions = true, -- Default: show permission prompts for all tools
            auto_check_diagnostics = true,
        },

        windows = {
            position = "smart", -- right, left, top, bottom, smart
            wrap = true, -- similar to vim.o.wrap
            width = 40, -- default % based on available width in vertical layout
        },
		mappings = {
			--- @class AvanteConflictMappings
			diff = {
				ours = "co",
				theirs = "ca",
				all_theirs = "CA",
				both = "cb",
				cursor = "cc",
				next = "]x",
				prev = "[x",
			},
            submit = {
                normal = "<CR>",
                insert = "<CR>",
            },
            sidebar = {
                edit_user_request = "e",
                switch_windows = "<Tab>",
                reverse_switch_windows = "<S-Tab>",
                remove_file = "d",
                add_file = "a",
                close = { "<Esc>", "q", "<C-c>" },
                close_from_input = {
                    normal = { "<Esc>", "q", "<C-c>" },
                    insert = { "<Esc>", "<C-c>" },
                },
            },
		},
	},
}
