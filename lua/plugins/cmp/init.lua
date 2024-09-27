return {
    "hrsh7th/nvim-cmp",
    event = { "InsertEnter", "CmdlineEnter" },
    ebabled = true,
    dependencies = {
        "L3MON4D3/LuaSnip",
        "saadparwaiz1/cmp_luasnip",
        "hrsh7th/cmp-nvim-lsp",
        "hrsh7th/cmp-buffer",
        "hrsh7th/cmp-path",
        -- "hrsh7th/cmp-emoji",
        "hrsh7th/cmp-cmdline",
        {
            "onsails/lspkind-nvim",
            config = function ()
                require('lspkind').init({
                    symbol_map = {
                        Copilot = "",
                    },
                })
            end
        },
        "hrsh7th/cmp-nvim-lua",
        "zbirenbaum/copilot-cmp",
        -- "hrsh7th/cmp-nvim-lsp-signature-help",     --require("luasnip.loaders.from_vscode").lazy_load()
        'rafamadriz/friendly-snippets',
        'petertriho/cmp-git'
    },
    config = function()
        local cmp = require("cmp")
        require("luasnip.loaders.from_vscode").lazy_load()
        vim.api.nvim_set_hl(0, "CmpItemKindcopilot", { fg = "#31A8FF", bg = "None" })
        cmp.setup({
            experimental = {
                ghost_text = false,
            },
            -- view ={
            --     entries = {name = 'custom', selection_order = 'near_cursor' }
            -- },
            snippet = {
                expand = function(args)
                    require('luasnip').lsp_expand(args.body)
                end,
            },
            sources = cmp.config.sources({
                --{ name = 'nvim_lsp_signature_help' },
                { name = "path" },
                { name = "copilot",group_index=1 },
                { name = "nvim_lsp", group_index = 2 },
                { name = 'luasnip', group_index = 2, max_item_count = 3 },
                { name = 'buffer',group_index = 3 },
            }),
            window = {
                completion    = cmp.config.window.bordered(),
                documentation = cmp.config.window.bordered()
            },
            mapping = require("plugins.cmp.keybindings").cmp(cmp),
            sorting = {
                priority_weight = 2,
                comparators = {
                    require("copilot_cmp.comparators").prioritize,
                    -- Below is the default comparitor list and order for nvim-cmp
                    cmp.config.compare.offset,
                    -- cmp.config.compare.scopes, --this is commented in nvim-cmp too
                    cmp.config.compare.exact,
                    cmp.config.compare.score,
                    cmp.config.compare.recently_used,
                    cmp.config.compare.locality,
                    cmp.config.compare.kind,
                    cmp.config.compare.sort_text,
                    cmp.config.compare.length,
                    cmp.config.compare.order,
                },
            },
            formatting = {
                expandable_indicator = true,
                fields = { cmp.ItemField.Abbr, cmp.ItemField.Kind, cmp.ItemField.Menu },
                -- fields = { cmp.ItemField.Abbr },
                format = require("lspkind").cmp_format({
                    with_text = true, -- do not show text alongside icons
                    maxwidth = 50, -- prevent the popup from showing more than provided characters (e.g 50 will not show more than 50 characters)
                    show_labelDetails = true,
                    before = function (entry, vim_item)
                        -- Source
                        vim_item.menu = "["..string.upper(entry.source.name).."]"
                        return vim_item
                    end
                })
            },
        })

        -- Use buffer source for `/`.
        cmp.setup.cmdline({ '/', '?' }, {
            mapping = cmp.mapping.preset.cmdline(),
            sources = {
                { name = 'buffer' },
            },
        })
        --Use cmdline & path source for ':'.
        cmp.setup.cmdline(':', {
            mapping = cmp.mapping.preset.cmdline(),
            sources = cmp.config.sources({
                { name = 'path' },
                { name = 'cmdline',
                option={
                    ignore_cmds = {"Tabularize/",'wqall','wq','wall','term','terminal','qall','quit','write', 'Man', '!'},
                },
                }
            }),
        })
        -- Set configuration for specific filetype.
        cmp.setup.filetype('gitcommit', {
            sources = cmp.config.sources({
                { name = 'git' }, -- You can specify the `git` source if [you were installed it](https://github.com/petertriho/cmp-git).
            }, {
                { name = 'buffer' },
            })
        })
    end
}













