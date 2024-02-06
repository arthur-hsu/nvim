return{
    {
        'nvim-focus/focus.nvim',
        event = "VeryLazy",
        enabled = false,
        config = function ()
            require("focus").setup({
                autoresize = {
                    enable = true, -- Enable or disable auto-resizing of splits
                    width = 0, -- Force width for the focused window
                    height = 0, -- Force height for the focused window
                    minwidth = 0, -- Force minimum width for the unfocused window
                    minheight = 0, -- Force minimum height for the unfocused window
                    height_quickfix = 10, -- Set the height of quickfix panel
                },
                ui = {
                    number = true, -- Display line numbers in the focussed window only
                    relativenumber = true, -- Display relative line numbers in the focussed window only
                    hybridnumber = true, -- Display hybrid line numbers in the focussed window only
                    absolutenumber_unfocussed = false, -- Preserve absolute numbers in the unfocussed windows

                    cursorline = true, -- Display a cursorline in the focussed window only
                    cursorcolumn = false, -- Display cursorcolumn in the focussed window only
                    colorcolumn = {
                        enable = true, -- Display colorcolumn in the foccused window only
                        list = '+1', -- Set the comma-saperated list for the colorcolumn
                    },
                    signcolumn = true, -- Display signcolumn in the focussed window only
                    winhighlight = false, -- Auto highlighting for focussed/unfocussed windows
                }
            })
        end
    },
    {
        "anuvyklack/windows.nvim",
        dependencies = {
            "anuvyklack/middleclass",
            "anuvyklack/animation.nvim"
        },
        event = "VeryLazy",
        enabled = false,
        config = function()
            vim.o.winwidth = 10
            vim.o.winminwidth = 10
            vim.o.equalalways = false
            require('windows').setup({
                autowidth = {			--		       |windows.autowidth|
                    enable = true,
                    winwidth = 5,			--		        |windows.winwidth|
                    filetype = {			--	      |windows.autowidth.filetype|
                        help = 2,
                    },
                },
                ignore = {				--			  |windows.ignore|
                    buftype = { "quickfix" },
                    filetype = { "NvimTree", "neo-tree", "undotree", "gundo" }
                },
                animation = {
                    enable = true,
                    duration = 200,
                    fps = 30,
                    easing = "in_out_sine"
                }
            })
        end
    },
}
