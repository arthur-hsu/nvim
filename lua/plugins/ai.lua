return {
	{
		"zbirenbaum/copilot.lua",
		cmd = "Copilot",
		event = "VeryLazy",
        -- enabled = false,
		opts = {
			panel = { enabled = false },
			suggestion = {
				enabled = false,
				auto_trigger = true,
				debounce = 500,
				keymap = {
					accept = false, --"<C-a>",
					accept_word = false,
					accept_line = false,
					next = "<M-]>",
					prev = "<M-[>",
					dismiss = "<C-c>",
				},
			},
			filetypes = {
				["*"] = true,
                -- ["python"] = true,
			},
            -- copilot_model = "gpt-4o-copilot",
			copilot_node_command = "node", -- Node.js version must be > 16.x
			server_opts_overrides = {
				trace = "verbose",
				settings = {
					advanced = {
						listCount = 10, -- #completions for panel
						inlineSuggestCount = 3, -- #completions for getCompletions
					},
				},
			},
		},
		config = function(_, opts)
			require("copilot").setup(opts)
		end,
	},
	{
		"milanglacier/minuet-ai.nvim",
		event = "VeryLazy",
        enabled = false,
		dependencies = {
			{ "nvim-lua/plenary.nvim" },
		},
		config = function()
			require("minuet").setup({
				provider = "gemini",
				blink = {
					enable_auto_complete = false,
				},
				provider_options = {
					gemini = {
						model = "gemini-2.5-flash",
						-- model = "gemini-2.5-pro",
						optional = {
							generationConfig = {
								maxOutputTokens = 256,
								-- When using `gemini-2.5-flash`, it is recommended to entirely
								-- disable thinking for faster completion retrieval.
								thinkingConfig = {
									thinkingBudget = 0,
								},
							},
						},
					},
				},
			})
		end,
	},
    {
        "supermaven-inc/supermaven-nvim",
        event = "VeryLazy",
        enabled = false,
        config = function()
            require("supermaven-nvim").setup({
                disable_keymaps = true,
                disable_inline_completion = true,
            })
        end,
    },
}
