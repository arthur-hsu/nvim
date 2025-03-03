return {
	-- NOTE: highlight CursorWord
	"sontungexpt/stcursorword",
	enabled = false,
	event = "VeryLazy",
	config = function()
		-- default configuration
		require("stcursorword").setup({
			max_word_length = 100, -- if cursorword length > max_word_length then not highlight
			min_word_length = 2, -- if cursorword length < min_word_length then not highlight
			excluded = {
				filetypes = {
					"TelescopePrompt",
					"alpha",
					"mason",
					"lazy",
					"DiffviewFileHistory",
					"DiffviewFiles",
					"Trouble",
					"lspinfo",
				},
				buftypes = {
					"nofile",
					"help",
					"terminal",
				},
				patterns = { -- the pattern to match with the file path
					-- "%.png$",
					-- "%.jpg$",
					-- "%.jpeg$",
					-- "%.pdf$",
					-- "%.zip$",
					-- "%.tar$",
					-- "%.tar%.gz$",
					-- "%.tar%.xz$",
					-- "%.tar%.bz2$",
					-- "%.rar$",
					-- "%.7z$",
					-- "%.mp3$",
					-- "%.mp4$",
				},
			},
			highlight = {
				underline = false,
				-- reverse = true,
				bg = nil,
				fg = nil,
				bold = true,
				-- bg = '#191919',
				-- fg = '#b3b8f5',
			},
		})
		vim.cmd("Cursorword disable")
	end
}
