return{
    {
        'norcalli/nvim-colorizer.lua',
        event = 'VeryLazy',
        config = function ()
            require'colorizer'.setup()
        end
    },
    {
        'nvim-tree/nvim-web-devicons',
        lazy = true,
        --event = 'VeryLazy',
    },
    {
        'dstein64/vim-startuptime',
        event = 'VeryLazy',
    },
    {
        "nathom/filetype.nvim",
        --lazy=true
        event = 'VeryLazy',
    },
    {
        "sindrets/diffview.nvim",
        event = 'VeryLazy',
    },
    {
        'scrooloose/nerdcommenter',
        event = 'VeryLazy',
    },
    {
        'iamcco/markdown-preview.nvim',
        lazy = false,
        event = 'VimEnter',
        config = function()
            --vim.fn["mkdp#util#install"]()
            vim.keymap.set('n', '<leader>mark', "<CMD>MarkdownPreview<CR>", { noremap = true, silent = true })
        end,
    },
    {
        'TobinPalmer/pastify.nvim',
        lazy = true,
        event = 'VeryLazy',
        cmd = { 'Pastify' },
        config = function ()
            require('pastify').setup {
                opts = {
                    absolute_path = false, -- use absolute or relative path to the working directory
                    apikey = 'c88b2f2193424aa23e2b6f870d544176', -- Api key, required for online saving
                    local_path = '/assets/imgs/', -- The path to put local files in, ex ~/Projects/<name>/assets/images/<imgname>.png
                    save = 'online', -- Either 'local' or 'online'
                },
                ft = { -- Custom snippets for different filetypes, will replace $IMG$ with the image url
                    html = '<img src="$IMG$" alt="">',
                    markdown = '![]($IMG$)',
                    tex = [[\includegraphics[width=\linewidth]{$IMG$}]],
                },
            }
        end
    }
}
