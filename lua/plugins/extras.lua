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
        event="VimEnter",
        config= function ()
            require("transparent").setup({ -- Optional, you don't have to run setup.
                groups = { -- table: default groups
                    'Normal', 'NormalNC', 'Comment', 'Constant', 'Special', 'Identifier',
                    'Statement', 'PreProc', 'Type', 'Underlined', 'Todo', 'String', 'Function',
                    'Conditional', 'Repeat', 'Operator', 'Structure', 'LineNr', 'NonText',
                    'SignColumn', 'CursorLine', 'CursorLineNr', 'StatusLine', 'StatusLineNC',
                    'EndOfBuffer',
                },
                -- table: additional groups that should be cleared
                extra_groups = {
                    "Folded",
                    "FoldColumn",
                    "UfoCursorFoldedLine",
                    "UfoFoldedBg"
                },
                -- table: groups you don't want to clear
                exclude_groups = {
                    "NotifyBackground",
                    'CursorLineNr',
                },
            })
            require('transparent').clear_prefix('lualine')
            
        end
    },
    {
        'godlygeek/tabular',
        event = 'VeryLazy',
    },
    {
        "sontungexpt/stcursorword",
        event = "VeryLazy",
        config = function ()
            -- default configuration
            require("stcursorword").setup({
                max_word_length = 100, -- if cursorword length > max_word_length then not highlight
                min_word_length = 2, -- if cursorword length < min_word_length then not highlight
                excluded = {
                    filetypes = {
                        "TelescopePrompt",
                        "alpha",
                    },
                    buftypes = {
                        -- "nofile",
                        "help",
                        "terminal",
                    },
                    patterns = { -- the pattern to match with the file path
                    -- "%.png$",
                    -- "%.jpg$",
                    -- "%.jpeg$",
                    -- "%.pdf$",
                    -- "%.zip$",
                    -- "%.tar$",
                    -- "%.tar%.gz$",
                    -- "%.tar%.xz$",
                    -- "%.tar%.bz2$",
                    -- "%.rar$",
                    -- "%.7z$",
                    -- "%.mp3$",
                    -- "%.mp4$",
                },
            },
            highlight = {
                underline = false,
                fg = '#dcd7ba',
                bg = "#2d4f67",
            },
        })
        -- 定義一個變量來追蹤光標單詞高亮的啟用狀態
        local cursorword_highlight_enabled = true

        -- 定義一個函數來切換光標單詞高亮
        function ToggleCursorWordHighlight()
            if cursorword_highlight_enabled then
                -- 如果當前是啟用狀態，則執行禁用命令
                vim.cmd('CursorwordDisable')
                cursorword_highlight_enabled = false
            else
                -- 如果當前是禁用狀態，則執行啟用命令
                vim.cmd('CursorwordEnable')
                cursorword_highlight_enabled = true
            end
        end

        vim.api.nvim_create_user_command('CursorwordToggle', ToggleCursorWordHighlight, {})

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
                    local_path = '/screenshot/', -- The path to put local files in, ex ~/Projects/<name>/assets/images/<imgname>.png
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
    {
        'dstein64/vim-startuptime',
        event="VimEnter",
        enabled = false,
    }
}
