local M = {
    'nvim-treesitter/nvim-treesitter',
    build = function()
        require("nvim-treesitter.install").update({ with_sync = true })
    end,
    -- enabled =false,
    -- event = { "BufReadPost", "BufNewFile" },
    -- event = { "VeryLazy", "BufReadPost", "BufNewFile" },
    -- event = {"VeryLazy"}
    -- event = "LspAttach",
    lazy = true,
}

function M.config()
    require("nvim-treesitter.install").compilers = { "gcc", "clang", "mingw" }
    require 'nvim-treesitter.configs'.setup {
        auto_install     = true,
        sync_install     = true,
        ensure_installed = { "python", "bash", "json", "vim", "vimdoc", "markdown", "markdown_inline", "lua", "regex" }, -- or all
        highlight        = {
            enable = true,
        },
        indent           = {
            enable = true,
            disable = { 'lua' },
        },
        ignore_install   = { "gitcommit" },
    }
end

return M
