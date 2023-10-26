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
        event = 'VimEnter',
        --event = { "BufReadPost", "BufNewFile" },
        opts ={
            exclude_groups = {'bufferline'},
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
    { 
        'gen740/SmoothCursor.nvim',
        event = 'VeryLazy',
        config = function()
            require('smoothcursor').setup({
                autostart = true,
                cursor = "",              -- cursor shape (need nerd font)
                texthl = "SmoothCursor",   -- highlight group, default is { bg = nil, fg = "#FFD400" }
                linehl = nil,              -- highlight sub-cursor line like 'cursorline', "CursorLine" recommended
                type = "default",          -- define cursor movement calculate function, "default" or "exp" (exponential).
                fancy = {
                    enable = true,        -- enable fancy mode
                    head = { cursor = "▷", texthl = "SmoothCursor", linehl = nil },
                    body = {
                        { cursor = "", texthl = "SmoothCursorRed" },
                        { cursor = "", texthl = "SmoothCursorOrange" },
                        { cursor = "●", texthl = "SmoothCursorYellow" },
                        { cursor = "●", texthl = "SmoothCursorGreen" },
                        { cursor = "•", texthl = "SmoothCursorAqua" },
                        { cursor = ".", texthl = "SmoothCursorBlue" },
                        { cursor = ".", texthl = "SmoothCursorPurple" },
                    },
                    tail = { cursor = nil, texthl = "SmoothCursor" }
                },
                flyin_effect = nil,        -- "bottom" or "top"
                speed = 25,                -- max is 100 to stick to your current position
                intervals = 35,            -- tick interval
                priority = 10,             -- set marker priority
                timeout = 3000,            -- timout for animation
                threshold = 3,             -- animate if threshold lines jump
                disable_float_win = true, -- disable on float window
                enabled_filetypes = nil,   -- example: { "lua", "vim" }
                disabled_filetypes = {
                    "help",
                    "alpha",
                    "TelescopePrompt",
                    "NvimTree",
                    "lazy",
                    "DiffviewFileHistory",
                    "DiffviewFiles"
                },  -- this option will be skipped if enabled_filetypes is set. example: { "TelescopePrompt", "NvimTree" }
            })
        end
    },
}
