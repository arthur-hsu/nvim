return {
    {
        "tadmccorkle/markdown.nvim",
        enabled = false,
        ft = { "markdown" },
    },
    {
        "SCJangra/table-nvim",
        ft = { "markdown" },
        enabled = true,
        opts = {
            padd_column_separators = true, -- Insert a space around column separators.
            mappings = {           -- next and prev work in Normal and Insert mode. All other mappings work in Normal mode.
                -- next = '<TAB>',    -- Go to next cell.
                -- prev = '<S-TAB>',  -- Go to previous cell.
                next = '<A-]>',    -- Go to next cell.
                prev = '<A-[>',  -- Go to previous cell.
                insert_row_up = '<A-k>', -- Insert a row above the current row.
                insert_row_down = '<A-j>', -- Insert a row below the current row.
                move_row_up = '<A-S-k>', -- Move the current row up.
                move_row_down = '<A-S-j>', -- Move the current row down.
                insert_column_left = '<A-h>', -- Insert a column to the left of current column.
                insert_column_right = '<A-l>', -- Insert a column to the right of current column.
                move_column_left = '<A-S-h>', -- Move the current column to the left.
                move_column_right = '<A-S-l>', -- Move the current column to the right.
                insert_table = '<A-t>', -- Insert a new table.
                insert_table_alt = '<A-S-t>', -- Insert a new table that is not surrounded by pipes.
                delete_column = '<A-d>', -- Delete the column under cursor.
            }
        }
    },
    {
        'MeanderingProgrammer/render-markdown.nvim',
        ft = { 'markdown' },
        dependencies = { 'nvim-treesitter/nvim-treesitter', 'echasnovski/mini.nvim' }, -- if you use the mini.nvim suite
        -- dependencies = { 'nvim-treesitter/nvim-treesitter', 'echasnovski/mini.icons' }, -- if you use standalone mini plugins
        -- dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-tree/nvim-web-devicons' }, -- if you prefer nvim-web-devicons
        ---@module 'render-markdown'
        ---@type render.md.UserConfig
        opts = {},
    },
    {
        'arthur-hsu/pastify.nvim',
        -- ft = { "markdown" },
        -- event = "VeryLazy",
        cmd = { 'Pastify' },
        config = function()
            require('pastify').setup {
                opts = {
                    absolute_path = false,                              -- use absolute or relative path to the working directory
                    apikey        = 'c88b2f2193424aa23e2b6f870d544176', -- Api key, required for online saving
                    local_path    = '/screenshot/',                     -- The path to put local files in, ex ~/Projects/<name>/assets/images/<imgname>.png
                    save          = 'online',                           -- Either 'local' or 'online'
                },
                ft = {                                                  -- Custom snippets for different filetypes, will replace $IMG$ with the image url
                    html     = '<img src="$IMG$" alt="">',
                    markdown = '![image]($IMG$)',
                    tex      = [[\includegraphics[width=\linewidth]{$IMG$}]],
                },
            }
        end
    },
    {
        "iamcco/markdown-preview.nvim",
        -- ft = { "markdown" },
        cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
        build = function() vim.fn["mkdp#util#install"]() end,
        config = function()
            vim.keymap.set('n', '<leader>md', "<CMD>MarkdownPreviewToggle<CR>", { noremap = true, silent = true })
            vim.g.mkdp_auto_close        = true
            vim.g.mkdp_open_to_the_world = false
            vim.g.mkdp_open_ip           = "127.0.0.1"
            vim.g.mkdp_port              = "8888"
            --vim.g.mkdp_browser         = ""
            vim.g.mkdp_echo_preview_url  = false
            vim.g.mkdp_page_title        = "${name}"
            vim.g.mkdp_theme             = 'dark'
        end
    }
}
