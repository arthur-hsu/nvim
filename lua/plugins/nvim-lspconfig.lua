return {
    -- lspconfig
    {
        "neovim/nvim-lspconfig",
        event = { "BufReadPre", "BufNewFile" },
        dependencies = {
            'hrsh7th/cmp-nvim-lsp',
            "williamboman/mason.nvim",
            "williamboman/mason-lspconfig.nvim",
        },
        ---@class PluginLspOpts
        opts = {
            -- options for vim.diagnostic.config()
            -- Automatically format on save
            autoformat = true,
            -- options for vim.lsp.buf.format
            -- `bufnr` and `filter` is handled by the LazyVim formatter,
            -- but can be also overriden when specified
            format = {
                formatting_options = nil,
                timeout_ms = nil,
            },
            -- LSP Server Settings
            ---@type lspconfig.options
            servers = {
                -- ruff_lsp = {},
                pyright = {

                    -- capabilities = {
                    --     textDocument = {
                    --         publishDiagnostics = {
                    --             tagSupport = {
                    --                 valueSet = {2},
                    --             },
                    --         },
                    --     },
                    -- },
                    settings={
                        python={

                            analysis={
                                diagnosticSeverityOverrides = {
                                    --typeCheckingMode = 'off',
                                    --reportUndefinedVariable = "none",
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
                                }
                            }
                        }
                    },
                },
                docker_compose_language_service = {},
                dockerls = {},
                html     = {},
                marksman = {},
                jsonls   = {},
                yamlls   = {},
                bashls   = {},
                lua_ls = {
                    -- mason = false, -- set to false if you don't want this server to be installed with mason
                    settings = {
                        Lua = {
                            diagnostics = { globals = {'vim'} },
                            workspace = {
                                checkThirdParty = false,
                            },
                            completion = {
                                callSnippet = "Replace",
                            },
                        },
                    },
                },
            },
            setup = {},
            },
            ---@param opts PluginLspOpts
            config = function(plugin, opts)
                local servers = opts.servers
                local capabilities = require("cmp_nvim_lsp").default_capabilities()
                capabilities.textDocument.foldingRange = {
                    dynamicRegistration = false,
                    lineFoldingOnly = true,
                }
                capabilities.textDocument.completion.completionItem.snippetSupport = true
                capabilities.textDocument.completion.completionItem.resolveSupport = {
                    properties = { "documentation", "detail", "additionalTextEdits" },
                }
                capabilities.textDocument.completion.completionItem.documentationFormat     = { 'markdown', 'plaintext' }
                capabilities.textDocument.completion.completionItem.preselectSupport        = true
                capabilities.textDocument.completion.completionItem.insertReplaceSupport    = true
                capabilities.textDocument.completion.completionItem.labelDetailsSupport     = true
                capabilities.textDocument.completion.completionItem.deprecatedSupport       = true
                capabilities.textDocument.completion.completionItem.commitCharactersSupport = true
                capabilities.textDocument.completion.completionItem.tagSupport              = { valueSet = { 1 } }

                local function setup(server)
                    local server_opts = servers[server] or {}
                    server_opts.capabilities = capabilities
                    if opts.setup[server] then
                        if opts.setup[server](server, server_opts) then
                            return
                        end
                    elseif opts.setup["*"] then
                        if opts.setup["*"](server, server_opts) then
                            return
                        end
                    end
                    require("lspconfig")[server].setup(server_opts)
                end

                local mlsp = require("mason-lspconfig")
                local available = mlsp.get_available_servers()

                local ensure_installed = {} ---@type string[]
                for server, server_opts in pairs(servers) do
                    if server_opts then
                        server_opts = server_opts == true and {} or server_opts
                        -- run manual setup if mason=false or if this is a server that cannot be installed with mason-lspconfig
                        if server_opts.mason == false or not vim.tbl_contains(available, server) then
                            setup(server)
                        else
                            ensure_installed[#ensure_installed + 1] = server
                        end
                    end
                end
                require("mason-lspconfig").setup({ ensure_installed = ensure_installed })
                require("mason-lspconfig").setup_handlers({ setup })
            end,
        },
    }
