
local Linter_and_Formatter = {
    -- Formatter
    "stylua",
    "prettier",
    "shfmt",

    -- Linter
    "markdownlint",
}

local servers_config = {
    ruff                            = {
        root_markers = { 'pyproject.toml', 'setup.py', 'setup.cfg', 'requirements.txt', 'Pipfile', 'pyrightconfig.json', '.git', },
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
    },
    pyright                         = {
        settings = {
            root_markers = { 'pyproject.toml', 'setup.py', 'setup.cfg', 'requirements.txt', 'Pipfile', 'pyrightconfig.json', '.git', },
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

    },
    docker_compose_language_service = {},
    dockerls                        = {},
    -- emmet_language_server           = {
    --     filetypes = {
    --         'css',
    --         'eruby',
    --         'html',
    --         'htmldjango',
    --         'javascriptreact',
    --         'less',
    --         'pug',
    --         'sass',
    --         'scss',
    --         'typescriptreact',
    --         'htmlangular',
    --         'markdown',
    --     },
    --
    -- },
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
            'hrsh7th/cmp-nvim-lsp',
            {
                "williamboman/mason.nvim",
                cmd = "Mason",
                opts = {
                    max_concurrent_installers = 4,
                    ui = { border = "rounded" },
                },
                -- ---@param opts MasonSettings | {ensure_installed: string[]}
                config = function(_, opts)
                    require("mason").setup(opts)
                end,
            },
            {
                "williamboman/mason-lspconfig.nvim",
                branch = "v1.x",
            },
        },
        ---@class PluginLspOpts
        opts = {
            -- options for vim.diagnostic.config()
            -- Automatically format on save
            -- autoformat = true,
            single_file_support = true,
            -- options for vim.lsp.buf.format
            -- `bufnr` and `filter` is handled by the LazyVim formatter,
            -- but can be also overriden when specified
            format = {
                formatting_options = nil,
                timeout_ms = nil,
            },
            -- LSP Server Settings
            ---@type lspconfig.options
            servers = servers_config,
            setup = {},
        },
        
        ---@param opts PluginLspOpts
        config = function(plugin, opts)
            local servers      = opts.servers
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

            local function setup_handler(server)
                local server_opts = servers[server] or {}
                -- server_opts.on_attach = function (client, bufnr)
                --     -- print('Attached to client', client.name, bufnr)
                --     vim.notify("Attached to client " .. client.name .. " on buffer " .. bufnr, vim.log.levels.INFO)
                -- end
                if server == 'pyright' then
                    capabilities.textDocument.completion.completionItem.tagSupport.valueSet = { 2 }
                end
                
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

            require("mason-lspconfig").setup()
            require("mason-lspconfig").setup_handlers({ setup_handler })

            local mlsp = require("mason-lspconfig")
            local available = mlsp.get_available_servers()
            for server, server_opts in pairs(servers) do
                if server_opts then
                    server_opts = server_opts == true and {} or server_opts
                    -- run manual setup if mason=false or if this is a server that cannot be installed with mason-lspconfig
                    if server_opts.mason == false or not vim.tbl_contains(available, server) then
                        setup_handler(server)
                    end
                end
            end
        end
    },
    {
        "WhoIsSethDaniel/mason-tool-installer.nvim",
        -- enabled = false,
        event = "VeryLazy",
        commit = "09caa33",
        opts = function()
            local ensure_installed = {} ---@type string[]
            -- local lsp_server = require("mason-lspconfig").get_installed_servers()
            for server, _  in pairs(servers_config) do
                ensure_installed[#ensure_installed + 1] = server
            end
            for _, lint in ipairs(Linter_and_Formatter) do
                ensure_installed[#ensure_installed + 1] = lint
            end
            return {
                ensure_installed = ensure_installed,
            }
        end,

        config = function(_, opts)
            require("mason-tool-installer").setup(opts)
            vim.cmd [[MasonToolsUpdate]]
        end
    }
}
