return {
	"hrsh7th/nvim-cmp",
	-- event = { "InsertEnter", "CmdlineEnter" },
	event = "VeryLazy",
	-- enabled = false,
	dependencies = {
		{ "L3MON4D3/LuaSnip", build = "make install_jsregexp" },
		"saadparwaiz1/cmp_luasnip",
		"hrsh7th/cmp-nvim-lsp",
		"hrsh7th/cmp-buffer",
		"hrsh7th/cmp-path",
		-- "hrsh7th/cmp-emoji",
		"hrsh7th/cmp-cmdline",
		{
			"onsails/lspkind-nvim",
			config = function()
				require("lspkind").init({
					symbol_map = {
						Copilot = "",
						Supermaven = "",
						claude = "󰋦",
						openai = "󱢆",
						codestral = "󱎥",
						gemini = "",
						Groq = "",
						Openrouter = "󱂇",
						Ollama = "󰳆",
						["Llama.cpp"] = "󰳆",
						Deepseek = "",
					},
				})
				vim.api.nvim_set_hl(0, "CmpItemKindSupermaven", { fg = "#6CC644" })
				vim.api.nvim_set_hl(0, "CmpItemKindcopilot", { fg = "#31A8FF", bg = "None" })
			end,
		},
		"hrsh7th/cmp-nvim-lua",
		{
			"zbirenbaum/copilot-cmp",
			-- enabled = false,
			config = function()
				require("copilot_cmp").setup()
			end,
		},
		"zbirenbaum/copilot.lua",
		-- "rafamadriz/friendly-snippets",
		"petertriho/cmp-git",
	},
	opts = function()
		local cmp = require("cmp")
		return {
			enabled = true,
			experimental = {
				ghost_text = false,
			},
			completion = {
				-- 這裡必須明確寫出，不要讓它使用系統預設的 "menu,popup"
				completeopt = "menu,menuone,noinsert,fuzzy",
			},
			preselect = cmp.PreselectMode.None,
			view = {
				entries = { name = "custom", selection_order = "neal_cursor", follow_cursor = true },
			},
			performance = {
				-- It is recommended to increase the timeout duration due to
				-- the typically slower response speed of LLMs compared to
				-- other completion sources. This is not needed when you only
				-- need manual completion.
				fetching_timeout = 2000,
			},
			sources = cmp.config.sources({
				{ name = "path" },
				{ name = "copilot", group_index = 2 },
				{ name = "minuet", group_index = 2 },
				{ name = "supermaven", group_index = 2 },
				{ name = "nvim_lsp", group_index = 2, max_item_count = 20 },
				{ name = "render-markdown", group_index = 2 },
				-- { name = "luasnip"         , group_index = 3, max_item_count = 3 },
				{ name = "buffer", group_index = 3 },
			}),
			-- sources = cmp.config.sources({
			-- 	{ name = "nvim_lsp", priority = 1000, max_item_count = 20 },
			-- 	{ name = "copilot", priority = 900 },
			-- 	{ name = "supermaven", priority = 800 },
			-- 	{ name = "path", priority = 500 },
			-- }, {
			-- 	{ name = "buffer", priority = 250 },
			-- }),
			sorting = {
				priority_weight = 2,
				comparators = {
					-- Below is the default comparitor list and order for nvim-cmp
					require("copilot_cmp.comparators").prioritize,
					cmp.config.compare.offset,
					-- cmp.config.compare.scopes, --this is commented in nvim-cmp too
					cmp.config.compare.exact,
                    cmp.config.compare.score,
					cmp.config.compare.recently_used,
					cmp.config.compare.locality,
					cmp.config.compare.kind,
					cmp.config.compare.sort_text,
					cmp.config.compare.length,
					cmp.config.compare.order,
				},
			},
			window = {
				completion = cmp.config.window.bordered({}),
				documentation = cmp.config.window.bordered(),
			},
			mapping = require("plugins.cmp.keybindings").keybind(cmp),
			formatting = {
				expandable_indicator = true,
				fields = { cmp.ItemField.Abbr, cmp.ItemField.Kind, cmp.ItemField.Menu },
				-- fields = { cmp.ItemField.Abbr },
				format = require("lspkind").cmp_format({
                    -- mode = "symbol", -- show only symbol annotations
					with_text = true, -- do not show text alongside icons
					maxwidth = 50, -- prevent the popup from showing more than provided characters (e.g 50 will not show more than 50 characters)
					-- maxheight = 5, -- prevent the popup from showing more than provided lines (e.g 3 will not show more than 3 lines)
					show_labelDetails = true,
					before = function(entry, vim_item)
                        local name = entry.source.name
                        local client_name = ""
                        local icon = ""
                        local hl_group = "CMPItemMenu"

                        local has_devicons, devicons = pcall(require, "nvim-web-devicons")

                        if name == "nvim_lsp" then
                            local client = entry.source.source.client
                            client_name = client.name
                            local ft = client.config.filetypes and client.config.filetypes[1] or nil

                            if has_devicons and ft then
                                -- 取得圖示與顏色名稱 (例如 "DevIconGo")
                                icon, hl_group = devicons.get_icon_by_filetype(ft, { default = true })
                            end
                        else
                            client_name = name
                            -- client_name = name
                            local Client_name = client_name:gsub("^%l", string.upper)

                            icon = require("lspkind").symbol_map[Client_name] or ""
                            hl_group = "CmpItemKind" .. Client_name
                            -- 檢查該高亮組是否存在
                            if vim.fn.hlexists(hl_group) == 0 then
                                hl_group = "CmpItemMenu"
                            end
                        end

                        -- 組合 Menu 內容
                        local menu
                        if icon == "" then
                            menu = string.upper(client_name)
                        else
                            menu = icon .. " " .. string.upper(client_name)
                        end

                        vim_item.menu = menu
                    
                        -- 將圖示顏色套用到 menu 欄位
                        if hl_group then
                            vim_item.menu_hl_group = hl_group
                        end

                        return vim_item
                    end
				}),
			},
		}
	end,
	config = function(_, opts)
		local cmp = require("cmp")
		require("luasnip.loaders.from_vscode").lazy_load()

		cmp.setup(opts)

		-- Use buffer source for `/`.
		cmp.setup.cmdline({ "/", "?" }, {
			mapping = cmp.mapping.preset.cmdline(),
			sources = {
				{ name = "buffer" },
			},
		})
		--Use cmdline & path source for ':'.
		cmp.setup.cmdline(":", {
			mapping = cmp.mapping.preset.cmdline(),
			sources = cmp.config.sources({
				{ name = "path" },
				{
					name = "cmdline",
					option = {
						ignore_cmds = {
							"Tabularize/",
							"wqall",
							"wq",
							"wall",
							"term",
							"terminal",
							"qall",
							"quit",
							"write",
							"Man",
							"!",
						},
					},
				},
				{ name = "nvim_lua" },
			}),
		})
		-- Set configuration for specific filetype.
		cmp.setup.filetype("gitcommit", {
			sources = cmp.config.sources({
				{ name = "git" }, -- You can specify the `git` source if [you were installed it](https://github.com/petertriho/cmp-git).
			}, {
				{ name = "buffer" },
			}),
		})
	end,
}
