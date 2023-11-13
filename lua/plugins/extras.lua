return{
    {
        'NvChad/nvim-colorizer.lua',
        event = { "BufReadPost", "BufNewFile" },
        --event = 'VeryLazy',
        config = function ()
            require'colorizer'.setup({})
            --require("colorizer").attach_to_buffer(0, { mode = "background", css = true})
        end
    },
    {
        'xiyaowong/transparent.nvim',
        lazy=false,
        -- enabled=false,
        -- event = { "BufReadPost", "BufNewFile" },
        opts={
            extra_groups={
                "NormalFloat",
                "TelescopePrompt",
                "BufferLine",
                "BufferLineFill",
                "BufferLineTab",
                "BufferLineTabSelected",
            },
            exclude_groups={
                "NotifyBackground",
            }
        },
        config= function ()
            require('transparent').clear_prefix('lualine')
        end
    },
    {
        'nvim-tree/nvim-web-devicons',
        lazy = true,
    },
    {
        "nathom/filetype.nvim",
        event = "VimEnter",
        --event = 'VeryLazy',
    },
    {
        "sindrets/diffview.nvim",
        event = 'VeryLazy',
    },
    {
        'TobinPalmer/pastify.nvim',
        lazy = true,
        event = {'BufEnter *.md', "BufRead *.md", "BufNewFile *.md" },
        cmd = { 'Pastify' },
        config = function ()
            require('pastify').setup {
                opts = {
                    absolute_path = false, -- use absolute or relative path to the working directory
                    apikey = 'c88b2f2193424aa23e2b6f870d544176', -- Api key, required for online saving
                    local_path = '/Document/screenshot/', -- The path to put local files in, ex ~/Projects/<name>/assets/images/<imgname>.png
                    save = 'local', -- Either 'local' or 'online'
                },
                ft = { -- Custom snippets for different filetypes, will replace $IMG$ with the image url
                    html = '<img src="$IMG$" alt="">',
                    markdown = '![image]($IMG$)',
                    tex = [[\includegraphics[width=\linewidth]{$IMG$}]],
                },
            }
        end
    },
    {
        'lithammer/nvim-pylance',
        enabled = false,
        lazy=true,
    },
}
