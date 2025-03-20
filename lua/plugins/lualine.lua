local colors = {
	bg           = "#202328",
	fg           = "#BBC2CF",
	yellow       = "#F7C251",
	cyan         = "#008080",
	darkblue     = "#081633",
	green        = "#88D97B",
	orange       = "#FEA405",
	violet       = "#A9A1E1",
	magenta      = "#C678DD",
	lightblue    = "#61AFEF",
	blue         = "#31A8FF",
	red          = "#E95678",
	offline      = "#B3DEEF",
	bg_visual    = "#89C0CF",
	light_purple = "#B3B8F5",
	mac          = "#A9B3B9",
}

local mode_color = {
	n      = colors.magenta,
	i      = colors.green,
	v      = colors.blue,
	V      = colors.blue,
	c      = colors.magenta,
	no     = colors.red,
	s      = colors.orange,
	S      = colors.orange,
	[""] = colors.orange,
	ic     = colors.yellow,
	R      = colors.violet,
	Rv     = colors.violet,
	cv     = colors.red,
	ce     = colors.red,
	r      = colors.cyan,
	rm     = colors.cyan,
	["r?"] = colors.cyan,
	["!"]  = colors.red,
	t      = colors.red,
	multi  = colors.blue,
}

local file_detial = function(scope)
	local file_icon, icon_color, cterm_color = require("nvim-web-devicons").get_icon_colors(vim.fn.expand("%:t"))
	local detial = {
		icon = file_icon,
		color = icon_color,
		cterm = cterm_color,
	}
	return detial[scope]
end


local conditions = {
	buffer_not_empty = function()
		return vim.fn.empty(vim.fn.expand("%:t")) ~= 1
	end,
	hide_in_width = function()
		return vim.fn.winwidth(0) > 80
	end,
	check_git_workspace = function()
		local filepath = vim.fn.expand("%:p:h")
		local gitdir = vim.fn.finddir(".git", filepath .. ";")
		return gitdir and #gitdir > 0 and #gitdir < #filepath
	end,
}
return {
	"nvim-lualine/lualine.nvim",
	dependencies = {
		"nvim-tree/nvim-web-devicons",
        'AndreM222/copilot-lualine',
	},
	event = "VeryLazy",
	opts = function()
		local config = {
			extensions = { "lazy" },
			options = {
				-- Disable sections and component separators
				disabled_filetypes = { -- Filetypes to disable lualine for.
					statusline = { "NvimTree", "diffpanel" }, -- only ignores the ft for statusline.
					winbar = { "NvimTree", "diffpanel", "alpha" }, -- only ignores the ft for winbar.
				},
				globalstatus = true,
				component_separators = "",
				section_separators = "",
				theme = {
					-- We are going to use lualine_c an lualine_x as left and
					-- right section. Both are highlighted by c theme .  So we
					-- are just setting default looks o statusline
					normal = { c = { fg = colors.fg, bg = "None" } },
					inactive = { c = { fg = colors.fg, bg = "None" } },
				},
			},
			sections = {
				-- these are to remove the defaults
				lualine_a = {},
				lualine_b = {},
				lualine_y = {},
				lualine_z = {},
				-- These will be filled later
				lualine_c = {},
				lualine_x = {},
			},
			inactive_sections = {
				-- these are to remove the defaults
				lualine_a = {},
				lualine_b = {},
				lualine_y = {},
				lualine_z = {},
				lualine_c = {},
				lualine_x = {},
			},
		}
		-- Inserts a component in lualine_c at left section
		local function ins_left(component)
			table.insert(config.sections.lualine_c, component)
		end

		-- Inserts a component in lualine_x at right section
		local function ins_right(component)
			table.insert(config.sections.lualine_x, component)
		end

		-- Mode --
		ins_left({
			-- mode component
			function()
				local mode
				if vim.b.visual_multi ~= nil then
					mode = "multi"
				else
					mode = vim.fn.mode()
				end
				Mode_text = {
					n = "NORMAL",
					i = "INSERT",
					c = "COMMAND",
					v = "VISUAL",
					V = "V-LINE",
					[""] = "V-BLOCK",
					R = "REPLACE",
					t = "TERMINAL",
					multi = "MULTI-LINE",
				}
				Mode_icon = {
					n = "",
					i = "",
					c = "",
					v = "󰯍", -- 󰓡 󰡎 󰯍 󰝡 
					V = "󰯎", -- 󰓢 󰡏 󰯎 󰕏 
					[""] = "",
					R = "",
					t = "",
					multi = "󰷫",
				}
				return " " .. Mode_icon[mode] .. " " .. (Mode_text[mode] or mode)
			end,
			color = function()
				local mode
				if vim.b.visual_multi ~= nil then
					mode = "multi"
				else
					mode = vim.fn.mode()
				end
				return { fg = mode_color[mode], gui = "bold", bg = "None" }
			end,
			padding = { right = 1 },
			cond = conditions.buffer_not_empty,
		})

		-- Filename & Icon --
		ins_left({
			function()
				return vim.fn.expand("%:t")
			end,
			cond = conditions.buffer_not_empty,
			color = function()
				return {
					fg = (file_detial("color") or mode_color[vim.fn.mode()]),
					gui = "bold",
					bg = "None",
				}
			end,
		})

		ins_left({
			function()
				local arrow = require("arrow.statusline")
				local text = arrow.text_for_statusline_with_icons()
				return text
			end,
			cond = function()
				local arrow = require("arrow.statusline")
				local is_on_arrow_file = arrow.is_on_arrow_file()
				return is_on_arrow_file ~= nil
			end,
			color = function()
				return {
					fg = (file_detial("color") or mode_color[vim.fn.mode()]),
					gui = "bold",
					bg = "None",
				}
			end,
		})

		-- Location & Progress --
		ins_left({
            "location",
            color = { fg = colors.yellow, bg = "None" },
			cond = conditions.buffer_not_empty,
        })
		ins_left({
            "progress",
            color = { fg = colors.yellow, bg = "None" },
			cond = conditions.buffer_not_empty,
        })

		-- Insert mid section. You can make any number of sections in neovim :)
		-- for lualine it's any number greater then 2
		-- LSP --
		ins_left({
			function()
				return "%="
			end,
		}) -- Must be here

		ins_left({
			-- Lsp server name .
			function()
				local msg = " "
				local buf_ft = vim.api.nvim_buf_get_option(0, "filetype")
				local clients = vim.lsp.get_active_clients()
				if buf_ft == "alpha" or buf_ft == "snacks_dashboard" then
					return "        " .. "Practice makes perfect"
				end
				if next(clients) == nil then
					return msg
				end
				for _, client in ipairs(clients) do
					-- vim.print(client.name)
					local filetypes = client.config.filetypes
					if filetypes and vim.fn.index(filetypes, buf_ft) ~= -1 then
						return file_detial("icon") .. " " .. client.name
					end
				end
				return msg
			end,
			-- icon = ,
			color = function()
				return {
					fg = (file_detial("color") or mode_color[vim.fn.mode()]),
					gui = "bold",
					bg = "None",
				}
			end,
		})

		-- Diagnostic --
		ins_right({
			"diagnostics",
			sources = { "nvim_diagnostic" },
			sections = { "error", "warn" },
			symbols = {
				error = " ",
				warn = " ",
				info = " ",
				hint = "󰝶 ",
			},
			diagnostics_color = {
				color_error = { fg = colors.red, bg = "None" },
				color_warn = { fg = colors.yellow, bg = "None" },
				color_info = { fg = colors.cyan, bg = "None" },
				color_hint = { fg = colors.fg, bg = "None" },
			},
		})

		-- Diff --
		ins_right({
			"diff",
			-- Is it me or the symbol for modified us really weird
			-- symbols = { added = ' ', modified = ' ', removed = ' ' },
			diff_color = {
				added = { fg = colors.green, bg = "None" },
				modified = { fg = colors.orange, bg = "None" },
				removed = { fg = colors.red, bg = "None" },
			},
			cond = conditions.hide_in_width,
		})
		-- Encoding type --
		ins_right({
			"o:encoding", -- option component same as &encoding in viml
			fmt = string.upper, -- I'm not sure why it's upper case either ;)
			-- cond = conditions.hide_in_width,
			cond = conditions.buffer_not_empty,
			color = { fg = colors.yellow, gui = "bold", bg = "None" },
		})
		-- File format --
		ins_right({
            "filetype",
			cond = conditions.buffer_not_empty,
        })

		-- Lazy status --
		ins_right({
			require("lazy.status").updates,
			cond = require("lazy.status").has_updates,
			color = { fg = colors.green },
		})

		-- OS --
		local os = vim.loop.os_uname().sysname
		if os == "Linux" then
			os = io.popen("lsb_release -i -s"):read("*l")
		end
		ins_right({
			function()
				local os_icons = {
					["Windows_NT"] = "",
					["Darwin"]     = "",
					["Debian"]     = "",
					["Ubuntu"]     = "",
				}
				return (os_icons[os] or "")
			end,
			color = function()
				local os_color = {
					["Windows_NT"] = { fg = "#087CD5", bg = "None" },
					["Darwin"]     = { fg = colors.mac, bg = "None" },
					["Debian"]     = { fg = "#D91857", bg = "None" },
					["Ubuntu"]     = { fg = "#DD4814", bg = "None" },
				}
				return (os_color[os] or { fg = "#88D97B", bg = "None" })
			end,
		})
		-- Branch --
		ins_right({
			"branch",
			icon = "󰘬",
			color = { fg = colors.magenta, gui = "bold", bg = "None" },
		})

		-- Copilot --
        ins_right({
            "copilot",
            symbols = {
                status = {
                    icons = {
                        enabled = " ",
                        sleep = " ", -- auto-trigger disabled
                        disabled = " ",
                        warning = " ",
                        unknown = " "
                    },
                    hl = {
                        enabled  = colors.blue,
                        sleep    = "#AEB7D0",
                        disabled = "#6272A4",
                        warning  = "#FFB86C",
                        unknown  = "#FF5555"
                    }
                },
                spinners = "dots", -- has some premade spinners
                spinner_color = "#6272A4"
            },
            show_colors = true,
        })
        return config
	end,
	config = function(_, opts)
		require("lualine").setup(opts)
	end
}
