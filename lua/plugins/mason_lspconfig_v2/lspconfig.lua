

local servers_config = {
    ruff                            = {
        init_options = {
            settings = {
                lint = {
                    ignore = {
                        "F541",
                        "F401",
                        "E401",
                        "E701",
                        "F841",
                        "E722",
                    }
                }
            }
        }
    },
    pyright                         = {
        -- for Disable "XXX" is not accessed
        -- handlers = {
        --     ["textDocument/publishDiagnostics"] = function(_, result, ctx, config)
        --         local new_diagnostics = {}
        --         for _, diagnostic in ipairs(result.diagnostics) do
        --             if not string.find(diagnostic.message, "is not accessed") then
        --                 table.insert(new_diagnostics, diagnostic)
        --             end
        --         end
        --         -- 更新结果中的诊断列表
        --         result.diagnostics = new_diagnostics
        --         -- 调用默认的处理函数
        --         vim.lsp.diagnostic.on_publish_diagnostics(nil, result, ctx, config)
        --     end,
        -- },
        settings = {
            pyright = {
                disableOrganizeImports = true,
            },
            python = {
                analysis = {
                    typeCheckingMode = 'basic',
                    -- ignore = { '*' },
                    diagnosticSeverityOverrides = {
                        reportUndefinedVariable          = "none",
                        reportUnusedImport               = "none",
                        reportMissingImports             = "none",
                        reportUnusedVariable             = "none",
                        reportUnboundVariable            = "none",
                        reportGeneralTypeIssues          = "none",
                        reportOptionalMemberAccess       = "none",
                        reportArgumentType               = "none",
                        reportOperatorIssue              = "none",
                        reportOptionalSubscript          = "none",
                        reportOptionalIterable           = "none",
                        reportIncompatibleMethodOverride = "none",
                        reportCallIssue                  = "none",
                        reportPrivateImportUsage         = "none",
                        reportAttributeAccessIssue       = "none",
                    }
                }
            }
        },
    },
    docker_compose_language_service = {},
    dockerls                        = {},
    html = {
        filetypes = { 'html', 'templ', "markdown" },
    },
    marksman                        = {},
    jsonls                          = {},
    yamlls                          = {},
    bashls                          = {},
    lua_ls                          = {
        -- mason = false, -- set to false if you don't want this server to be installed with mason
        settings = {
            Lua = {
                diagnostics = {
                    globals = { 'vim' },
                    disable = { 'deprecated' }
                },
                workspace = {
                    checkThirdParty = false,
                },
                completion = {
                    callSnippet = "Replace",
                },
            },
        },
    },
}



return {
    -- lspconfig
    {
        "neovim/nvim-lspconfig",
        dependencies = {
            {
                'hrsh7th/cmp-nvim-lsp'
            },
        },
        ---@class PluginLspOpts
        opts = {
            -- options for vim.diagnostic.config()
            -- Automatically format on save
            -- autoformat = true,
            -- autostart = true,
            single_file_support = true,
            -- options for vim.lsp.buf.format
            -- `bufnr` and `filter` is handled by the LazyVim formatter,
            -- but can be also overriden when specified
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
            for server_name, server_opts in pairs(servers_config) do
                server_opts.capabilities = capabilities
                if server_name == 'pyright' then
                    server_opts.capabilities.textDocument.completion.completionItem.tagSupport.valueSet = { 2 }
                end
                vim.lsp.config(server_name, server_opts)
                vim.lsp.enable(server_name)
            end
            -- for server_name, server_opts in pairs(servers_config) do
            --     server_opts.capabilities = capabilities
            --     if server_name == 'pyright' then
            --         server_opts.capabilities.textDocument.completion.completionItem.tagSupport.valueSet = { 2 }
            --     end
            -- end

        end
    },
}
