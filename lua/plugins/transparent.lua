return {
	{
		"tribela/transparent.nvim",
		-- event = "VimEnter",
		opts = {
			auto = true, -- Automatically applies transparent
			extra_groups = { -- If you want to add some groups to be transparent. eg: { 'Pmenu', 'CocFloating' }
                "NormalFloat",
                "FloatBorder",
                "CursorLine",
                
			},
			excludes = {
                "PmenuSbar"
            }, -- If you want to excludes from default transparent groups. eg: { 'LineNr' }
		},
	},
}
