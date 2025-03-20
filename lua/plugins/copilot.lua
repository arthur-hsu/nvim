return {
	{
		"zbirenbaum/copilot.lua",
		cmd = "Copilot",
		event = "VeryLazy",
		opts = {
			panel = {
				enabled = false,
				auto_refresh = true,
				keymap = {
					jump_prev = "[[",
					jump_next = "]]",
					accept = "<CR>",
					refresh = "gr",
					-- open      = "<M-CR>"
					open = "<M-t>",
				},
				layout = {
					position = "bottom", -- | top | left | right
					ratio = 0.4,
				},
			},
			suggestion = {
				enabled = true,
				auto_trigger = true,
				debounce = 50,
				keymap = {
					accept = false, --"<C-a>",
					accept_word = false,
					accept_line = false,
					next = "<M-]>",
					prev = "<M-[>",
					dismiss = "C-c",
				},
			},
			filetypes = {
				["*"] = true,
			},
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
			local keys = {
				["tab"] = vim.api.nvim_replace_termcodes("<Tab>", true, true, true),
				["cmp"] = vim.api.nvim_replace_termcodes("<CR>", true, true, true),
				["ctrl-tab"] = vim.api.nvim_replace_termcodes("<C-Tab>", true, true, true),
			}
			_G.tab_action = function()
				if require("cmp").get_selected_entry() ~= nil then
					return keys["cmp"]
                elseif require("copilot.suggestion").is_visible() then
					require("copilot.suggestion").accept()
					return
				else
					return keys["tab"]
				end
			end
			-- vim.keymap.set("i", "<Tab>", "v:lua._G.tab_action()", { expr = true })
            vim.keymap.set('i', '<Tab>', function() return _G.tab_action() end, { expr = true })
		end,
	},
}
