local M = {
    'nvim-treesitter/nvim-treesitter',
    build = function()
		require("nvim-treesitter.install").update({ with_sync = true })
	end,
    --enabled =false,
    event = { "BufReadPost", "BufNewFile" },
    dependencies = {'HiPhish/nvim-ts-rainbow2'},
}

function M.config()
    require("nvim-treesitter.install").compilers = { "gcc", "clang", "mingw" }
    require'nvim-treesitter.configs'.setup {
        auto_install = true,
        ensure_installed = {"python","bash"},
        highlight = {
            enable = true,
        },
        indent = {
            enable = true,
        },
        --ensure_installed = {"bash","python","html", "css", "vim", "lua","json","vimdoc", "markdown","markdown_inline",'c','cpp',
        --'glsl','hlsl','ispc','java','javascript','objc','proto','perl','jsonnet','cuda','matlab','sql','cmake','arduino',
        --'julia','prql','puppet','starlark','t32','tsx','v','wgsl_bevy'},
        rainbow = {
            enable = true,
            -- list of languages you want to disable the plugin for
            disable = { 'jsx', 'cpp' },
            -- Which query to use for finding delimiters
            query = 'rainbow-parens',
            -- Highlight the entire buffer all at once
            strategy = require('ts-rainbow').strategy.global,
            hlgroups = {
                'TSRainbowCyan',
                'TSRainbowGreen',
                'TSRainbowYellow',
                'TSRainbowBlue',
                'TSRainbowViolet',
                --'TSRainbowRed',
                --'TSRainbowOrange',
            },
        },
    }
    -- 开启 Folding
    vim.wo.foldmethod = 'expr'
    vim.wo.foldexpr = 'nvim_treesitter#foldexpr()'
    vim.wo.foldlevel = 99
end
return M
