local function ruff()

    local methods = require("null-ls.methods")
    local h = require("null-ls.helpers")

    local FORMATTING = methods.internal.FORMATTING

    return h.make_builtin({
        name = "ruff",
        meta = {
            url = "https://github.com/astral-sh/ruff/",
            description = "An extremely fast Python formatter, written in Rust.",
        },
        method = FORMATTING,
        filetypes = { "python" },
        generator_opts = {
            command = "ruff",
            args = { "format", "-n", "--stdin-filename", "$FILENAME", "-" },
            to_stdin = true,
        },
        factory = h.formatter_factory,
    })
end



return {
    {
        "nvimtools/none-ls.nvim",
        event = "VeryLazy",
        dependencies = { "mason.nvim", "nvim-lua/plenary.nvim" },
        opts = function()
            local null_ls = require("null-ls")
            return {
                debug = false,
                sources = {
                    null_ls.builtins.hover.dictionary,
                    -- null_ls.builtins.completion.spell,

                    null_ls.builtins.formatting.prettier,
                    null_ls.builtins.formatting.stylua,
                    null_ls.builtins.formatting.markdownlint,
                    null_ls.builtins.formatting.shfmt,
                    -- ruff()
                    null_ls.builtins.formatting.black,
                    -- null_ls.builtins.diagnostics.markdownlint

                },
            }
        end,
        config = function(_, opts)
            require("null-ls").setup(opts)

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
