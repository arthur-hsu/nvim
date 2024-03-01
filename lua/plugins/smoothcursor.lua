return {
    'gen740/SmoothCursor.nvim',
    event = 'VeryLazy',
    enabled = false,
    config = function()
        require('smoothcursor').setup({
            autostart = true,
            cursor    = "",            -- cursor shape (need nerd font)
            texthl    = "SmoothCursor", -- highlight group, default is { bg = nil, fg = "#FFD400" }
            linehl    = nil,            -- highlight sub-cursor line like 'cursorline', "CursorLine" recommended
            type      = "default",      -- Cursor movement calculation method, choose "default", "exp" (exponential) or "matrix".
            fancy = {
                enable = true,        -- enable fancy mode
                -- head = { cursor = "▷", texthl = "SmoothCursor", linehl = nil },
                head = { cursor = "", texthl = "SmoothCursor", linehl = nil },
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
            matrix = {  -- Loaded when 'type' is set to "matrix"
                head = {
                    -- Picks a random character from this list for the cursor text
                    cursor = require('smoothcursor.matrix_chars'),
                    -- Picks a random highlight from this list for the cursor text
                    texthl = {
                        'SmoothCursor',
                    },
                    linehl = nil,  -- No line highlight for the head
                },
                body = {
                    length = 6,  -- Specifies the length of the cursor body
                    -- Picks a random character from this list for the cursor body text
                    cursor = require('smoothcursor.matrix_chars'),
                    -- Picks a random highlight from this list for each segment of the cursor body
                    texthl = {
                        "SmoothCursorRed",
                        "SmoothCursorOrange",
                        "SmoothCursorYellow",
                        "SmoothCursorGreen",
                        "SmoothCursorAqua",
                        "SmoothCursorBlue",
                        "SmoothCursorPurple"
                    },
                },
                tail = {
                    -- Picks a random character from this list for the cursor tail (if any)
                    cursor = nil,
                    -- Picks a random highlight from this list for the cursor tail
                    texthl = {
                        'SmoothCursor',
                    },
                },
                unstop = true,  -- Determines if the cursor should stop or not (false means it will stop)
            },
            flyin_effect      = nil,  -- "bottom" or "top"
            speed             = 25,   -- max is 100 to stick to your current position
            intervals         = 35,   -- tick interval
            priority          = 10,   -- set marker priority
            timeout           = 3000, -- timout for animation
            threshold         = 3,    -- animate if threshold lines jump
            disable_float_win = true, -- disable on float window
            enabled_filetypes = nil,  -- example: { "lua", "vim" }
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
        local autocmd = vim.api.nvim_create_autocmd

        autocmd({ 'ModeChanged' }, {
            callback = function()
                local current_mode = vim.fn.mode()
                if current_mode == 'n' then
                    vim.api.nvim_set_hl(0, 'SmoothCursor', { fg = "#FFD400" })
                    vim.fn.sign_define('smoothcursor', { text = "" })
                elseif current_mode == 'v' then
                    vim.api.nvim_set_hl(0, 'SmoothCursor', { fg = '#2FA9FF' })
                    vim.fn.sign_define('smoothcursor', { text = '' })
                elseif current_mode == 'V' then
                    vim.api.nvim_set_hl(0, 'SmoothCursor', { fg = '#2FA9FF' })
                    vim.fn.sign_define('smoothcursor', { text = '' })
                elseif current_mode == '�' then -- V-block
                    vim.api.nvim_set_hl(0, 'SmoothCursor', { fg = '#2FA9FF' })
                    vim.fn.sign_define('smoothcursor', { text = '' })
                elseif current_mode == 'i' then
                    vim.api.nvim_set_hl(0, 'SmoothCursor', { fg = '#88D97B' })
                    vim.fn.sign_define('smoothcursor', { text = '' })
                end
            end,
        })

    end
}
