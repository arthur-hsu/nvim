return {
	{
		"kevinhwang91/nvim-ufo",
		-- event = { 'BufReadPost', 'BufNewFile' },
		event = "VeryLazy",
        -- stylua: ignore
        keys = {
            { 'zR', function() require('ufo').openAllFolds() end },
            { 'zM', function() require('ufo').closeAllFolds() end },
            { 'zr', function() require('ufo').openFoldsExceptKinds() end },
            { 'zm', function() require('ufo').closeFoldsWith(1) end },
            { 'K',  function()
                local winid = require('ufo').peekFoldedLinesUnderCursor()
                if not winid then vim.lsp.buf.hover() end
            end }
        },
		dependencies = {
			"kevinhwang91/promise-async",
		},
		opts = {
			filetype_exclude = { "help", "alpha", "dashboard", "neo-tree", "Trouble", "lazy", "mason" },
		},
		config = function()
			vim.api.nvim_set_hl(0, "Folded", { bold = true, italic = true })
			local handler = function(virtText, lnum, endLnum, width, truncate)
				local newVirtText = {}
				local suffix = ("  Hide %d lines "):format(endLnum - lnum)
				local sufWidth = vim.fn.strdisplaywidth(suffix)
				local targetWidth = width - sufWidth
				local curWidth = 0
				for _, chunk in ipairs(virtText) do
					local chunkText = chunk[1]
					local chunkWidth = vim.fn.strdisplaywidth(chunkText)
					if targetWidth > curWidth + chunkWidth then
						table.insert(newVirtText, chunk)
					else
						chunkText = truncate(chunkText, targetWidth - curWidth)
						local hlGroup = chunk[2]
						table.insert(newVirtText, { chunkText, hlGroup })
						chunkWidth = vim.fn.strdisplaywidth(chunkText)
						-- str width returned from truncate() may less than 2nd argument, need padding
						if curWidth + chunkWidth < targetWidth then
							suffix = suffix .. (" "):rep(targetWidth - curWidth - chunkWidth)
						end
						break
					end
					curWidth = curWidth + chunkWidth
				end
				table.insert(newVirtText, { suffix, "MoreMsg" })
				return newVirtText
			end

			local ftMap = {
				vim = "indent",
				python = { "indent" },
				git = "",
			}
			require("ufo").setup({
				fold_virt_text_handler = handler,
				open_fold_hl_timeout = 0,
				close_fold_kinds_for_ft = { default = { "imports", "comment" } },
				preview = {
					win_config = {
						border = { "", "─", "", "", "", "─", "", "" },
						winhighlight = "Normal:Folded",
						winblend = 0,
					},
					mappings = {
						scrollU = "<C-b>",
						scrollD = "<C-f>",
						jumpTop = "[",
						jumpBot = "]",
					},
				},
				provider_selector = function(bufnr, filetype, buftype)
					-- return ftMap[filetype]
					return ftMap[filetype] or { "treesitter", "indent" } -- if you prefer treesitter provider rather than lsp,
				end,
			})
		end,
	},
}
