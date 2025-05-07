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
	dependencies = {
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
                require("mason-lspconfig").setup({ automatic_enable = true })
            end
        }
	},
	opts = function()
		local ensure_installed = {} ---@type string[]
        server_config = vim.lsp.config
        function Add_lsp_server(tbl, indent)
            indent = indent or 0
            if indent == 2 then
                return
            end

            for key, value in pairs(tbl) do
                if type(value) == "table" then
                    Add_lsp_server(value, indent + 1)
                    if indent == 1 then
                        ensure_installed[#ensure_installed + 1] = key
                    end
                end
            end
        end
        Add_lsp_server(server_config)

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
