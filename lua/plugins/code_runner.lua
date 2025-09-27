return {
	"CRAG666/code_runner.nvim",
	dependencies = { "CRAG666/betterTerm.nvim" },
	event = "VeryLazy",
	config = function()
		require("code_runner").setup({
			-- choose default mode (valid term, tab, float, toggle)
			mode = "term",
			-- Focus on runner window(only works on toggle, term and tab mode)
			-- focus = true,
			-- startinsert (see ':h inserting-ex')
			startinsert = true,
			insert_prefix = "",
			term = {
				--  Position to open the terminal, this option is ignored if mode ~= term
				position = "bot",
				-- window size, this option is ignored if mode == tab
				size = 20,
			},
			float = {
				close_key = "<C-c>",
				border = "rounded",
				-- Num from `0 - 1` for measurements
				height = 0.3,
				width = 0.8,
				x = 0,
				y = 0.92,

				-- Highlight group for floating window/border (see ':h winhl')
				border_hl = "FloatBorder",
				float_hl = "Normal",

				-- Transparency (see ':h winblend')
				blend = 0,
			},
			better_term = { -- Toggle mode replacement
				clean = false, -- Clean terminal before launch
				number = nil, -- Use nil for dynamic number and set init
				init = nil,
			},
			filetype_path = "",
			-- Execute before executing a file
			before_run_filetype = function()
				vim.cmd("w")
			end,
			filetype = {
				javascript = "node",
				java = {
					"cd $dir &&",
					"javac $fileName &&",
					"java $fileNameWithoutExt",
				},
				c = {
					"cd $dir &&",
					"gcc $fileName",
					"-o $fileNameWithoutExt &&",
					"$dir/$fileNameWithoutExt",
				},
				cpp = {
					"cd $dir &&",
					"g++ $fileName",
					"-o $fileNameWithoutExt &&",
					"$dir/$fileNameWithoutExt",
				},
				-- python = python(),
				sh = "bash",
				rust = {
					"cd $dir &&",
					"rustc $fileName &&",
					"$dir/$fileNameWithoutExt",
				},
			},
			project_path = "",
			project = {},
			prefix = "",
		})
		-- vim.keymap.set("n", "<leader>e", function()
		-- 	require("betterTerm").send(
		-- 		require("code_runner.commands").get_filetype_command(),
		-- 		1,
		-- 		{ clean = false, interrupt = true }
		-- 	)
		-- end, { desc = "Excute File" })
	end
}

