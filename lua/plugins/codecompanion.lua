return {
	"olimorris/codecompanion.nvim",
    event = "VeryLazy",
	dependencies = {
		"nvim-lua/plenary.nvim",
	},
	opts = {
		interactions = {
			chat = {
				adapter = "gemini",
				model = "gemini-2.5-flash",
				opts = {
					completion_provider = "cmp", -- blink|cmp|coc|default
				},
			},
			inline = {
				adapter = {
					name = "gemini_cli",
					-- model = "claude-haiku-4-5-20251001",
				},
			},
		},
		-- NOTE: The log_level is in `opts.opts`
		opts = {
			log_level = "DEBUG",
		},
		adapters = {
			acp = {
				gemini_cli = function()
					return require("codecompanion.adapters").extend("gemini_cli", {
						commands = {
							default = {
								"some-other-gemini",
								"--experimental-acp",
							},
						},
						defaults = {
							auth_method = "gemini-api-key",
							timeout = 20000, -- 20 seconds
						},
						env = {
							GEMINI_API_KEY = function()
								return os.getenv("GEMINI_API_KEY")
							end,
						},
					})
				end,
			},
		},
	},
}
