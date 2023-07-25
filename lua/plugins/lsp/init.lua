return {
    -- lspconfig
    {
        "neovim/nvim-lspconfig",
        event = { "BufReadPre", "BufNewFile" },
        dependencies = {
            'hrsh7th/cmp-nvim-lsp',
            -- { "folke/neoconf.nvim", cmd = "Neoconf", config = true },
            --{ "folke/neodev.nvim", opts = { experimental = { pathStrict = true } } },
            "williamboman/mason.nvim",
            "williamboman/mason-lspconfig.nvim",
            -- "haringsrob/nvim_context_vt",
            -- { "simrat39/inlay-hints.nvim", config = true },
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

                jsonls = {},
                pyright = {
                    settings={
                        python={
                            analysis={
                                diagnosticSeverityOverrides = {
                                    reportUnboundVariable = "none",
                                    reportUndefinedVariable = "none",
                                    reportGeneralTypeIssues = "none",
                                    reportMissingImports = 'none',
                                    reportUnusedVariable = false,
                                }
                            }
                        }
                    }
                },

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
            -- you can do any additional lsp server setup here
            -- return true if you don't want this server to be setup with lspconfig
            ---@type table<string, fun(server:string, opts:_.lspconfig.options):boolean?>
            setup = {
                -- example to setup with typescript.nvim
                -- tsserver = function(_, opts)
                    --   require("typescript").setup({ server = opts })
                    --   return true
                    -- end,
                    -- Specify * to use this function as a fallback for any server
                    -- ["*"] = function(server, opts) end,
                },
            },
            ---@param opts PluginLspOpts
            config = function(plugin, opts)



                local servers = opts.servers
                local capabilities = require("cmp_nvim_lsp").default_capabilities(vim.lsp.protocol.make_client_capabilities())

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
