local Linter_and_Formatter = {
    -- Formatter
    "stylua",
    "prettier",
    "shfmt",
    -- Linter
    "markdownlint",
}

return {
	"WhoIsSethDaniel/mason-tool-installer.nvim",
    lazy = false,
	dependencies = {
        "neovim/nvim-lspconfig",
		{
			"williamboman/mason.nvim",
			cmd = "Mason",
			opts = {
				max_concurrent_installers = 4,
				ui = { border = "rounded" },
			},
			-- ---@param opts MasonSettings | {ensure_installed: string[]}
			config = function(_, opts)
				require("mason").setup(opts)
			end,
		},
        {
            "williamboman/mason-lspconfig.nvim",
            config = function()
                require("mason-lspconfig").setup({ automatic_enable = false })
            end
        }
	},
	opts = function()
		local ensure_installed = {} ---@type string[]

        local lsp_server = require("mason-lspconfig").get_installed_servers()
        for _, server in pairs(lsp_server) do
            ensure_installed[#ensure_installed + 1] = server
        end


		for _, lint in ipairs(Linter_and_Formatter) do
			ensure_installed[#ensure_installed + 1] = lint
		end

		return {
			ensure_installed = ensure_installed,
		}
	end,

	config = function(_, opts)
		require("mason-tool-installer").setup(opts)
		vim.cmd([[MasonToolsUpdate]])
	end,
}
