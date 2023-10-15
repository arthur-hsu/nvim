local M = {
    "hrsh7th/nvim-cmp",
    event = "InsertEnter",
    dependencies = {
        'L3MON4D3/LuaSnip',
        "saadparwaiz1/cmp_luasnip",
        "hrsh7th/cmp-nvim-lsp",
        "hrsh7th/cmp-buffer",
        "hrsh7th/cmp-path",
        "hrsh7th/cmp-emoji",
        "hrsh7th/cmp-cmdline",
        "onsails/lspkind-nvim",
        "hrsh7th/cmp-nvim-lua",
        --"hrsh7th/cmp-nvim-lsp-signature-help",     --require("luasnip.loaders.from_vscode").lazy_load()
        'rafamadriz/friendly-snippets'
    },
}


function M.config()
    local cmp = require("cmp")
    require("luasnip.loaders.from_vscode").lazy_load()
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
                ignore_cmds = {'term','terminal','qall','quit','write', 'Man', '!'},
            },
            }
        }),
    })
    cmp.setup({
        experimental = {
            ghost_text = false,
        },
        snippet = {
            expand = function(args)
                require('luasnip').lsp_expand(args.body)
            end,
        },
        sources = cmp.config.sources({
            --{ name = 'nvim_lsp_signature_help' },
            { name = "path" },
            { name = "nvim_lsp", group_index = 2 },
            { name = 'buffer',group_index = 3 },
            { name = 'luasnip', group_index = 1, max_item_count = 3 },
        }),
        window = {
            completion = cmp.config.window.bordered(),
            documentation = cmp.config.window.bordered()
        },
        mapping = require("plugins.cmp.keybindings").cmp(cmp),

        formatting = {
            expandable_indicator = true,
            --fields = {'menu', 'abbr', 'kind'},
            format = require("lspkind").cmp_format({
                with_text = true, -- do not show text alongside icons
                maxwidth = 50, -- prevent the popup from showing more than provided characters (e.g 50 will not show more than 50 characters)
                before = function (entry, vim_item)
                    -- Source
                    vim_item.menu = "["..string.upper(entry.source.name).."]"
                    return vim_item
                end
            })
        },
    })
end
return M












