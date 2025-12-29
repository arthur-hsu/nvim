local python_root_markers = {
    -- 'pyproject.toml',
    'setup.py',
    'setup.cfg',
    'requirements.txt',
    'Pipfile',
    'pyrightconfig.json',
    'ruff.toml',
    '.ruff.toml',
    '.git',
}



local Linter_and_Formatter = {
    -- Formatter
    "stylua",
    "prettier",
    "shfmt",
    -- "black",

    -- Linter
    "markdownlint",
    "golangci-lint",
}
local servers_config = {
    gopls = {
        completeUnimported = true,
        usePlaceholders = true,
        -- 增加補全結果的細節，有助於 cmp 排序
        completionDocumentation = true,
    },
    ruff                            = {
        root_markers = python_root_markers,
        init_options = {
            settings = {
                format = {
                    preview = true
                },
                lint = {
                    preview = true,
                    ignore = {
                        "F401",
                        "F541",
                        "F841",
                        "E401",
                        "E701",
                        "E722",
                    }
                }
            }
        }
    },

    basedpyright                         = {
        root_markers = python_root_markers,
        settings = {
            basedpyright = {
                disableOrganizeImports = true,
                analysis = {
                    inlayHints = {
                        variableTypes = false,
                    },
                    typeCheckingMode = 'basic', -- 'off' or 'basic'
                    -- ignore = { '*' }, -- ignore all warnings
                    diagnosticSeverityOverrides = {
                        -- reportUndefinedVariable          = "none",
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
                        reportReturnType                 = "none",
                        reportRedeclaration              = "none",

                        -- basedpyright diagnostics
                        reportUnknownParameterType       = "none",
                        reportUnknownVariableType        = "none",
                        -- reportUnknownVariableType        = "none",
                    }
                }
            },
            python = {}
        },
    },
    pyright                         = {
        root_markers = python_root_markers,

        settings = {
            pyright = {
                disableOrganizeImports = true,
            },
            python = {
                analysis = {
                    typeCheckingMode = 'basic', -- 'off' or 'basic'
                    -- ignore = { '*' }, -- ignore all warnings
                    diagnosticSeverityOverrides = {
                        -- reportUndefinedVariable          = "none",
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
                        reportReturnType                 = "none",
                        reportRedeclaration              = "none",

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
}
return {
    Linter_and_Formatter = Linter_and_Formatter,
    servers_config      = servers_config,
}
