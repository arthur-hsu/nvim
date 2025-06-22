return {
	{
		"nvim-treesitter/nvim-treesitter",
        dependencies = {
            {
                "LiadOz/nvim-dap-repl-highlights",
                -- branch = "nil-bufnr",
                commit = "a7512fc"
            }
        },
		build = function()
			require("nvim-treesitter.install").update({ with_sync = true })
		end,
		config = function()
			require("nvim-dap-repl-highlights").setup()
			require("nvim-treesitter.install").compilers = { "gcc", "clang", "mingw" }
			require("nvim-treesitter.configs").setup({
				auto_install = true,
				sync_install = true,
				ensure_installed = {
					"python",
					"bash",
					"json",
					"vim",
					"vimdoc",
					"markdown",
					"markdown_inline",
					"lua",
					"regex",
					"gitcommit",
					"diff",
					"dap_repl",
				}, -- or all
				highlight = {
					enable = true,
				},
				indent = {
					enable = true,
					disable = { "lua" },
				},
				-- ignore_install   = { "gitcommit" },
			})
			local color = require("zephyr")
			vim.api.nvim_set_hl(0, "@type.builtin", { fg = color.yellow })
			vim.api.nvim_set_hl(0, "@variable.builtin", { fg = color.red })
			vim.api.nvim_set_hl(0, "@variable.builtin.python", { fg = color.red, italic = true })
			vim.api.nvim_set_hl(0, "@module", { fg = color.yellow })
			vim.api.nvim_set_hl(0, "@boolean", { fg = color.magenta, bold = true })
			vim.api.nvim_set_hl(0, "@function.builtin", { fg = color.yellow })
			vim.api.nvim_set_hl(0, "@constant.builtin", { fg = color.yellow })
			vim.api.nvim_set_hl(0, "@constructor", { fg = color.yellow })
		end,
	},
	{
		"windwp/nvim-ts-autotag",
		ft = {
			"astro",
			"glimmer",
			"handlebars",
			"html",
			"javascript",
			"jsx",
			"markdown",
			"php",
			"rescript",
			"svelte",
			"tsx",
			"twig",
			"typescript",
			"vue",
			"xml",
		},
		dependencies = {
			"nvim-treesitter/nvim-treesitter",
		},
		config = function()
			require("nvim-ts-autotag").setup({
				opts = {
					-- Defaults
					enable_close = true, -- Auto close tags
					enable_rename = true, -- Auto rename pairs of tags
					enable_close_on_slash = true, -- Auto close on trailing </
				},
				-- Also override individual filetype configs, these take priority.
				-- Empty by default, useful if one of the "opts" global settings
				-- doesn't work well in a specific filetype
				-- per_filetype = {
				--     ["html"] = {
				--         enable_close = false,
				--     },
				-- },
			})
		end,
	},
}
