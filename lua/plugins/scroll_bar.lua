return {
	{
		"petertriho/nvim-scrollbar",
		-- lazy = true,
		event = "VeryLazy",
		dependencies = {
			{ "haya14busa/vim-asterisk" },
			{
				"kevinhwang91/nvim-hlslens",
                opts = {
                    -- override_lens = function(render, posList, nearest, idx, relIdx)
                    -- end,
                    override_lens = function(render, posList, nearest, idx, relIdx)
                        local sfw = vim.v.searchforward == 1
                        local indicator, text, chunks
                        local absRelIdx = math.abs(relIdx)
                        if absRelIdx > 1 then
                            indicator = ("%d%s"):format(absRelIdx, sfw ~= (relIdx > 1) and " ▲" or " ▼")
                        elseif absRelIdx == 1 then
                            indicator = sfw ~= (relIdx == 1) and " ▲" or " ▼"
                        else
                            indicator = ""
                        end

                        local lnum, col = unpack(posList[idx])
                        if nearest then
                            local cnt = #posList
                            if indicator ~= "" then
                                text = (" [%s %d/%d]"):format(indicator, idx, cnt)
                            else
                                text = (" [%d/%d]"):format(idx, cnt)
                            end
                            chunks = { { " " }, { text, "HlSearchLensNear" } }
                        else
                            text = (" [%s %d]"):format(indicator, idx)
                            chunks = { { " " }, { text, "HlSearchLens" } }
                        end
                        render.setVirt(0, lnum - 1, col - 1, chunks, nearest)
                    end,
                    build_position_cb = function(plist, _, _, _)
                        require("scrollbar.handlers.search").handler.show(plist.start_pos)
                    end,
				},
				config = function(_, opts)
					vim.api.nvim_set_hl(0, "HlSearchLens", { link = "DiagnosticVirtualTextInfo" })
					vim.api.nvim_set_hl(0, "HlSearchLensNear", { link = "BufferLineIndicatorSelected" })
					require("hlslens").setup(opts)

					local hlslens = require("hlslens")
					if hlslens then
						local overrideLens = function(render, posList, nearest, idx, relIdx)
							local _ = relIdx
							local lnum, col = unpack(posList[idx])

							local text, chunks
							if nearest then
								text = ("  [%d/%d]"):format(idx, #posList)
								chunks = { { " ", "Ignore" }, { text, "HlSearchLensNear" } }
							else
								text = ("  %d"):format(idx)
								chunks = { { " ", "Ignore" }, { text, "HlSearchLens" } }
							end
							render.setVirt(0, lnum - 1, col - 1, chunks, nearest)
						end
						local lensBak
						local config = require("hlslens.config")
						local gid = vim.api.nvim_create_augroup("VMlens", {})
						vim.api.nvim_create_autocmd("User", {
							pattern = { "visual_multi_start", "visual_multi_exit" },
							group = gid,
							callback = function(ev)
								if ev.match == "visual_multi_start" then
									lensBak = config.override_lens
									config.override_lens = overrideLens
								else
									config.override_lens = lensBak
								end
								hlslens.start()
							end,
						})
					end

					vim.cmd([[
                        augroup scrollbar_search_hide
                        autocmd!
                        autocmd CmdlineLeave : lua require('scrollbar.handlers.search').handler.hide()
                        augroup END
                    ]])
				end,
			},
		},
        opts = {
            handle = {
                blend = 70, -- Integer between 0 and 100. 0 for fully opaque and 100 to full transparent. Defaults to 30.
                color = "#B3B8F5",
            },

            marks = {
                Search = {
                    text = { "-" },
                    highlight = "HlSearchLensNear",
                },
                Info = {
                    text = { " " },
                    highlight = "CursorColumn",
                    priority = 99,
                },
                Hint = {
                    text = { " " },
                    highlight = "CursorColumn",
                    priority = 99,
                },
            },
            excluded_buftypes = {
                "terminal",
                "nofile",
            },
            excluded_filetypes = {
                "DiffviewFiles",
                "DiffviewFileHistory",
                "TelescopePrompt",
                "cmp_docs",
                "cmp_menu",
                "noice",
                "prompt",
                "lazy",
                "snacks_dashboard",
                "markdown",
            },
            handlers = {
                cursor = true,
                diagnostic = true,
                gitsigns = true, -- Requires gitsigns
                handle = true,
                search = true, -- Requires hlslens
                ale = false, -- Requires ALE
            },
        },
		config = function(_, opts)
			require("scrollbar").setup(opts)
			require("scrollbar.handlers.search").setup()
			require("scrollbar.handlers.gitsigns").setup()

			vim.api.nvim_set_keymap("n", "*", [[<Plug>(asterisk-z*)<Cmd>lua require('hlslens').start()<CR>]], {})
			vim.api.nvim_set_keymap("n", "#", [[<Plug>(asterisk-z#)<Cmd>lua require('hlslens').start()<CR>]], {})
			vim.api.nvim_set_keymap("n", "g*", [[<Plug>(asterisk-gz*)<Cmd>lua require('hlslens').start()<CR>]], {})
			vim.api.nvim_set_keymap("n", "g#", [[<Plug>(asterisk-gz#)<Cmd>lua require('hlslens').start()<CR>]], {})

			vim.api.nvim_set_keymap("x", "*", [[<Plug>(asterisk-z*)<Cmd>lua require('hlslens').start()<CR>]], {})
			vim.api.nvim_set_keymap("x", "#", [[<Plug>(asterisk-z#)<Cmd>lua require('hlslens').start()<CR>]], {})
			vim.api.nvim_set_keymap("x", "g*", [[<Plug>(asterisk-gz*)<Cmd>lua require('hlslens').start()<CR>]], {})
			vim.api.nvim_set_keymap("x", "g#", [[<Plug>(asterisk-gz#)<Cmd>lua require('hlslens').start()<CR>]], {})
		end,
	},
}
