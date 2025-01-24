return {
    {
        --NOTE: For beautiful sign column
        "luukvbaal/statuscol.nvim",
        -- event = 'VimEnter',
        config = function()
            local builtin = require("statuscol.builtin")
            require("statuscol").setup({
                -- configuration goes here, for example:
                relculright = true,
                separator = " ",
                -- ft_ignore = {"copilot-chat"},     -- lua table with 'filetype' values for which 'statuscolumn' will be unset
                -- bt_ignore = {"copilot-chat"}, -- lua table with 'buftype' values for which 'statuscolumn' will be unset

                segments = {
                    -- { sign = { name = { "smoothcursor" },text={ "smoothcursor" } } },
                    { text = { builtin.foldfunc, ' ' }, click = "v:lua.ScFa" },
                    -- {
                    --     sign = {  namespace = { "diagnostic/signs" }, maxwidth = 1,colwidth = 1, auto = true },
                    --     click = "v:lua.ScSa"
                    -- },
                    -- {
                    --     sign = { namespace = { "gitsigns" }, maxwidth = 1, auto = true },
                    --     click = "v:lua.ScSa",
                    -- },
                    { text = { builtin.lnumfunc, " " }, click = "v:lua.ScLa", },
                    -- {
                    --     sign = { name = { ".*" }, maxwidth = 2, colwidth = 1, auto = true, wrap = true },
                    --     click = "v:lua.ScSa"
                    -- },
                },
            })
            vim.cmd[[autocmd FileType copilot-chat set statuscolumn=]]
        end,
    },

}
