return {
	{
		"zbirenbaum/copilot.lua",
		cmd = "Copilot",
		event = "VeryLazy",
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
			},
            copilot_model = "gpt-5-mini",
            -- copilot_model = "claude-sonnet-4",
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
}
