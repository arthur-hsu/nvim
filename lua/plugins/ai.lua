return {
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
				-- Your configuration options here
			})
		end,
	},
    {
        "supermaven-inc/supermaven-nvim",
        event = "VeryLazy",
        config = function()
            require("supermaven-nvim").setup({
                disable_keymaps = true,
                disable_inline_completion = true,
            })
        end,
    },
}
