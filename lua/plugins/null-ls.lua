return{
    {
        "jose-elias-alvarez/null-ls.nvim",
        lazy = true,
        enabled = false,
        event = { "BufReadPre", "BufNewFile" },
        dependencies = { "mason.nvim",'nvim-lua/plenary.nvim'},
        opts = function()
            local null_ls = require("null-ls")
            return {
                border = "rounded",
                root_dir = require("null-ls.utils").root_pattern(".null-ls-root", ".neoconf.json", "Makefile", ".git"),
                sources = {
                    null_ls.builtins.formatting.black,
                    -- null_ls.builtins.diagnostics.eslint,
                    -- null_ls.builtins.diagnostics.pylint,
                    -- null_ls.builtins.completion.spell,
                },
            }
        end,
    },
}
