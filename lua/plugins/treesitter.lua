local M = {
    'nvim-treesitter/nvim-treesitter',
    build = function()
		require("nvim-treesitter.install").update({ with_sync = true })
	end,
    --enabled =false,
    event = { "BufReadPost", "BufNewFile" },
}

function M.config()
    require("nvim-treesitter.install").compilers = { "gcc", "clang", "mingw" }
    require'nvim-treesitter.configs'.setup {
        auto_install = true,
        sync_install = true,
        ensure_installed = {"python","bash","json",'vimdoc','gitcommit'}, -- or all
        highlight = {
            enable = true,
        },
        indent = {
            enable = true,
            disable = {'lua'},
        },
        rainbow = {
            enable = true,
            -- list of languages you want to disable the plugin for
            disable = { 'jsx', 'cpp' },
            -- Which query to use for finding delimiters
            query = 'rainbow-parens',
            -- Highlight the entire buffer all at once
            -- strategy = require('ts-rainbow').strategy.global,
            -- hlgroups = {
            --     'TSRainbowCyan',
            --     'TSRainbowGreen',
            --     'TSRainbowYellow',
            --     'TSRainbowBlue',
            --     'TSRainbowViolet',
            --     --'TSRainbowRed',
            --     --'TSRainbowOrange',
            -- },
        },
    }
    -- 开启 Folding
    vim.wo.foldmethod = 'expr'
    vim.wo.foldexpr = 'nvim_treesitter#foldexpr()'
    vim.wo.foldlevel = 99
end
return M
