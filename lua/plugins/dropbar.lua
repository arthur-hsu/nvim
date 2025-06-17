return {
    "Bekaboo/dropbar.nvim",
    -- optional, but required for fuzzy finder support
    enabled = false,
    event = "VeryLazy",
    dependencies = {
        "nvim-telescope/telescope-fzf-native.nvim",
        build = "make",
    },
    opts = {
        bar = {
            enable = function(buf, win, _)
                if
                    not vim.api.nvim_buf_is_valid(buf)
                    or not vim.api.nvim_win_is_valid(win)
                    or vim.fn.win_gettype(win) ~= ""
                    or vim.wo[win].winbar ~= ""
                    or vim.bo[buf].ft == "help"
                    or vim.bo[buf].buftype == "nowrite"
                    -- or vim.api.nvim_win_get_option(win, "diff")

                    -- or vim.bo[buf].buftype == ""
                then
                    return false
                end

                local stat = vim.uv.fs_stat(vim.api.nvim_buf_get_name(buf))
                if stat and stat.size > 1024 * 1024 then
                    return false
                end

                return vim.bo[buf].ft == "markdown"
                    or pcall(vim.treesitter.get_parser, buf)
                    or not vim.tbl_isempty(vim.lsp.get_clients({
                        bufnr = buf,
                        method = "textDocument/documentSymbol",
                    }))
            end,

            sources = function(buf, _)
                local sources = require("dropbar.sources")
                local utils = require('dropbar.utils')
                if vim.bo[buf].ft == "markdown" then
                    return {
                        sources.path,
                        sources.markdown,
                    }
                end
                if vim.bo[buf].buftype == "terminal" then
                    return {
                        sources.terminal,
                    }
                end
                return {
                    sources.path,
                    utils.source.fallback({
                        sources.lsp,
                        -- sources.treesitter,
                    }),
                }
            end,
        },
        menu = {
            scrollbar = {
                enable = true,
                background = true,
            },
            win_configs = {
                border = "rounded",
            },
            hover = false,
        },
    },
    config = function(_, opts)
        require("dropbar").setup(opts)
        local dropbar_api = require("dropbar.api")
        vim.keymap.set("n", "<Leader>;", dropbar_api.pick, { desc = "Pick symbols in winbar" })
        vim.keymap.set("n", "[;", dropbar_api.goto_context_start, { desc = "Go to start of current context" })
        vim.keymap.set("n", "];", dropbar_api.select_next_context, { desc = "Select next context" })
        vim.ui.select = require("dropbar.utils.menu").select
        -- vim.api.nvim_set_hl(0, 'DropBarMenuHoverIcon', { bg = '#1f2335' })
        vim.api.nvim_set_hl(0, "DropBarMenuHoverIcon", {})
    end,
}
