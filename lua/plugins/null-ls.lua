return {
    {
        "nvimtools/none-ls.nvim",
        -- enabled = false,
        event = "VeryLazy",
        dependencies = { "mason.nvim", "nvim-lua/plenary.nvim" },
        opts = function()
            local null_ls = require("null-ls")
            return {
                debug = false,
                sources = {
                    null_ls.builtins.hover.dictionary,
                    null_ls.builtins.completion.spell,

                    null_ls.builtins.formatting.prettier,
                    null_ls.builtins.formatting.stylua,
                    null_ls.builtins.formatting.markdownlint,
                    null_ls.builtins.formatting.shfmt,

                },
            }
        end,
        config = function(_, opts)
            require("null-ls").setup(opts)
            local null_ls = require("null-ls")
            local helpers = require("null-ls.helpers")

            local markdownlint = {
                method = null_ls.methods.DIAGNOSTICS,
                filetypes = { "markdown" },
                -- null_ls.generator creates an async source
                -- that spawns the command with the given arguments and options
                generator = null_ls.generator({
                    command = "markdownlint",
                    args = { "--stdin" },
                    to_stdin = true,
                    from_stderr = true,
                    -- choose an output format (raw, json, or line)
                    format = "line",
                    check_exit_code = function(code, stderr)
                        local success = code <= 1

                        if not success then
                            -- can be noisy for things that run often (e.g. diagnostics), but can
                            -- be useful for things that run on demand (e.g. formatting)
                            print(stderr)
                        end

                        return success
                    end,
                    -- use helpers to parse the output from string matchers,
                    -- or parse it manually with a function
                    on_output = helpers.diagnostics.from_patterns({
                        {
                            pattern = [[:(%d+):(%d+) [%w-/]+ (.*)]],
                            groups = { "row", "col", "message" },
                        },
                        {
                            pattern = [[:(%d+) [%w-/]+ (.*)]],
                            groups = { "row", "message" },
                        },
                    }),
                }),
            }

            null_ls.register(markdownlint)

            -- -- if you want to set up formatting on save, you can use this as a callback
            -- local augroup = vim.api.nvim_create_augroup("LspFormatting", {})
            --
            -- -- add to your shared on_attach callback
            -- local on_attach = function(client, bufnr)
            --     if client.supports_method("textDocument/formatting") then
            --         vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
            --         vim.api.nvim_create_autocmd("BufWritePre", {
            --             group = augroup,
            --             buffer = bufnr,
            --             callback = function()
            --                 lsp_formatting(bufnr)
            --             end,
            --         })
            --     end
            -- end
        end,
    },
}
