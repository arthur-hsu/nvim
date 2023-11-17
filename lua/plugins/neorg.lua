return {
    "nvim-neorg/neorg",
    build = ":Neorg sync-parsers",
    dependencies = { "nvim-lua/plenary.nvim" },
    event = "VimEnter",
    -- enabled = false,
    config = function()
        require("neorg").setup {
            load = {
                ["core.defaults"] = {},
                ["core.concealer"] = {},
                ["core.dirman"] = {
                    config = {
                        workspaces = {
                            notes = "~/Markdown_doc/neorg",
                        },
                        default_workspace = "notes",
                    },
                },
            },
        }
        vim.wo.foldlevel = 99
        vim.wo.conceallevel = 2
    end
}
