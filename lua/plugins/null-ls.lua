return{
    {
        "https://github.com/nvimtools/none-ls.nvim",
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
                    null_ls.builtins.formatting.prettier,
                    null_ls.builtins.formatting.stylua,
                    null_ls.builtins.formatting.markdownlint,
                    -- null_ls.builtins.formatting.jq,

                    -- null_ls.builtins.diagnostics.eslint,
                    -- null_ls.builtins.diagnostics.pylint,
                    -- null_ls.builtins.completion.spell,
                },
            }
        end,
        config = function ()
            local lsp_formatting = function(bufnr)
                vim.lsp.buf.format({
                    filter = function(client)
                        -- apply whatever logic you want (in this example, we'll only use null-ls)
                        return client.name == "null-ls"
                    end,
                    bufnr = bufnr,
                })
            end

            -- if you want to set up formatting on save, you can use this as a callback
            local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

            -- add to your shared on_attach callback
            local on_attach = function(client, bufnr)
                if client.supports_method("textDocument/formatting") then
                    vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
                    vim.api.nvim_create_autocmd("BufWritePre", {
                        group = augroup,
                        buffer = bufnr,
                        callback = function()
                            lsp_formatting(bufnr)
                        end,
                    })
                end
            end
        end
    },
}
