return {
    "https://github.com/luukvbaal/statuscol.nvim",
    -- enabled = false,
    event = 'VeryLazy',
    config = function()
        local builtin = require("statuscol.builtin")
        require("statuscol").setup({
            -- configuration goes here, for example:
            relculright = true,
            separator = " ",
            ft_ignore = nil,       -- lua table with 'filetype' values for which 'statuscolumn' will be unset
            bt_ignore = nil,       -- lua table with 'buftype' values for which 'statuscolumn' will be unset
            segments = {
                -- { sign = { name = { "smoothcursor" },text={ "smoothcursor" } } },
                { text = { builtin.foldfunc},click = "v:lua.ScFa" },
                {
                    sign = { name = { "Diagnostic" }, maxwidth = 1, auto = true },
                    click = "v:lua.ScSa"
                },
                { text = { builtin.lnumfunc }, click = "v:lua.ScLa", },
                {
                    sign = { name = { ".*" }, maxwidth = 2, colwidth = 1, auto = true, wrap = true },
                    click = "v:lua.ScSa"
                },
                { text = { " " }},
            }
        })
    end,
}
