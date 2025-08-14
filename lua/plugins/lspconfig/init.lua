
local lsp_config = require("plugins.lspconfig.lsp_config")
return {
    {
        "neovim/nvim-lspconfig",
        -- lazy = false,
        dependencies = {
            {
                "williamboman/mason.nvim",
                cmd = "Mason",
                opts = {
                    max_concurrent_installers = 4,
                    ui = { border = "rounded" },
                },
                config = function(_, opts)
                    require("mason").setup(opts)
                end,
            },
            {
                "williamboman/mason-lspconfig.nvim",
                -- config = function()
                --     require("mason-lspconfig").setup({ automatic_enable = true })
                -- end
            },
            {
                'hrsh7th/cmp-nvim-lsp'
            },
        },
        ---@class PluginLspOpts
        opts = {
            -- autostart = true,
            single_file_support = true,
        },
        
        ---@param opts PluginLspOpts
        config = function(plugin, opts)
            -- local capabilities = vim.lsp.protocol.make_client_capabilities()
            local capabilities = require("cmp_nvim_lsp").default_capabilities()
            capabilities.textDocument.foldingRange                                      = {
                dynamicRegistration = false,
                lineFoldingOnly     = true,
            }
            capabilities.textDocument.completion.completionItem.snippetSupport          = true
            capabilities.textDocument.completion.completionItem.resolveSupport          = {
                properties = { "documentation", "detail", "additionalTextEdits" },
            }
            capabilities.textDocument.completion.completionItem.documentationFormat     = { 'markdown', 'plaintext' }
            capabilities.textDocument.completion.completionItem.preselectSupport        = true
            capabilities.textDocument.completion.completionItem.insertReplaceSupport    = true
            capabilities.textDocument.completion.completionItem.labelDetailsSupport     = true
            capabilities.textDocument.completion.completionItem.deprecatedSupport       = true
            capabilities.textDocument.completion.completionItem.commitCharactersSupport = true
            capabilities.textDocument.completion.completionItem.tagSupport              = { valueSet = { 1 } }
            for server_name, server_opts in pairs(lsp_config.servers_config) do
                server_opts.capabilities = capabilities
                if server_name == 'pyright' then
                    capabilities.textDocument.completion.completionItem.tagSupport.valueSet = { 2 }
                end
                vim.lsp.config(server_name, server_opts)
            end
            require("mason-lspconfig").setup({ automatic_enable = true })
        end
    },
    {
        "WhoIsSethDaniel/mason-tool-installer.nvim",
        dependencies = {
            "neovim/nvim-lspconfig",
        },
        opts = function()
            local ensure_installed = {} ---@type string[]

            local lsp_server = require("mason-lspconfig").get_installed_servers()
            for _, server in pairs(lsp_server) do
                ensure_installed[#ensure_installed + 1] = server
            end


            for _, lint in ipairs(lsp_config.Linter_and_Formatter) do
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
}
