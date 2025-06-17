return {
	{
		"norcalli/nvim-colorizer.lua",
		-- event = { "BufReadPost", "BufNewFile" },
		event = "VeryLazy",
		config = function()
			require("colorizer").attach_to_buffer(0, { names = false, mode = "background", css = true })
		end,
	},
	{ "rcarriga/nvim-notify" },
	{ "nvim-tree/nvim-web-devicons" },
	{
		"ibhagwan/fzf-lua",
		-- optional for icon support
		event = "VeryLazy",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		config = function()
			-- calling `setup` is optional for customization
			require("fzf-lua").setup({
				lsp = {
					-- make lsp requests synchronous so they work with null-ls
					async_or_timeout = 3000,
				},
			})
		end,
	},
	{
		"hat0uma/csvview.nvim",
		ft = { "csv" },
		config = function()
			require("csvview").setup({
				view = {
					spacing = 0,
					display_mode = "border",
				},
			})
		end,
	},
	{
		"theKnightsOfRohan/csvlens.nvim",
		ft = { "csv" },
		dependencies = {
			"akinsho/toggleterm.nvim",
		},
		config = true,
	},
    {
        "fedepujol/move.nvim",
        event= "VeryLazy",
        keys = {
            -- Normal Mode
            { "<C-A-DOWN>",  ":MoveLine(1)<CR>",   desc = "Move Line Down",       noremap = true, silent = true},
            { "<C-A-UP>",    ":MoveLine(-1)<CR>",  desc = "Move Line Up",         noremap = true, silent = true},
            { "<C-A-LEFT>",  ":MoveWord(-1)<CR>", desc = "Move Word Left",  noremap = true, silent = true },
            { "<C-A-RIGHT>", ":MoveWord(1)<CR>",  desc = "Move Word Right", noremap = true, silent = true },
            -- Visual Mode
            { "<C-A-DOWN>",  ":MoveBlock(1)<CR>", mode = { "v" }, desc = "Move Block Up"    , noremap = true, silent = true},
            { "<C-A-UP>",    ":MoveBlock(-1)<CR>", mode = { "v" }, desc = "Move Block Down" , noremap = true, silent = true},
            { "<C-A-LEFT>", ":MoveHBlock(-1)<CR>", mode = { "v" }, desc = "Move Block Left" , noremap = true, silent = true },
            { "<C-A-RIGHT>",":MoveHBlock(1)<CR>", mode = { "v" }, desc = "Move Block Right", noremap = true, silent = true },
        },
        opts = {
            char = {
                enable = true -- Enables char movement
            }
        }
    }
}
