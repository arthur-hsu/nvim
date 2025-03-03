return {
	"folke/which-key.nvim",
	init = function()
		vim.o.timeout = true
		vim.o.timeoutlen = 320
	end,
	-- enabled = false,
	event = "VeryLazy",
	opts = {
		plugins = {
			marks = true,             -- shows a list of your marks on ' and `
			registers = true,         -- shows your registers on " in NORMAL or <C-r> in INSERT mode
			spelling = {
				enabled = false,      -- enabling this will show WhichKey when pressing z= to select spelling suggestions
				suggestions = 20,     -- how many suggestions should be shown in the list?
			},
			-- the presets plugin, adds help for a bunch of default keybindings in Neovim
			-- No actual key bindings are created
			presets = {
				operators = true,     -- adds help for operators like d, y, ... and registers them for motion / text object completion
				motions = true,       -- adds help for motions
				text_objects = true,  -- help for text objects triggered after entering an operator
				windows = true,       -- default bindings on <c-w>
				nav = true,           -- misc bindings to work with windows
				z = true,             -- bindings for folds, spelling and others prefixed with z
				g = true,             -- bindings for prefixed with g
			},
		},
		-- add operators that will trigger motion and text object completion
		-- to enable all native operators, set the preset / operators plugin above
		-- operators = { gc = "Comments" },

		icons = {
			breadcrumb = "»",                -- symbol used in the command line area that shows your active key combo
			separator = "➜",                 -- symbol used between a key and it's label
			group = "+",                     -- symbol prepended to a group
		},
		win = {
			border = "rounded",
		},
		layout = {
			height = { min = 4, max = 15 },  -- min and max height of the columns
			width = { min = 30, max = 60 },  -- min and max width of the columns
			spacing = 3,                     -- spacing between columns
			align = "center",                -- align columns left, center or right
		},
		-- ignore_missing = true, -- enable this to hide mappings for which you didn't specify a label
		show_help = true, -- show help message on the command line when the popup is visible
	},
}
