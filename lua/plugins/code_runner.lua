local M = {
    'https://github.com/CRAG666/code_runner.nvim',
    event="VeryLazy",
}



local function python()
    if vim.loop.os_uname().sysname == 'Linux' or 'Darwin' then
        return "python3 -u"
    elseif vim.loop.os_uname().sysname == 'Windows_NT' then
        return "python -u"
    end
end

function M.config()
    require('code_runner').setup({
        -- choose default mode (valid term, tab, float, toggle)
        mode = "term",
        --mode = "term",
        -- Focus on runner window(only works on toggle, term and tab mode)
        focus = true,
        -- startinsert (see ':h inserting-ex')
        startinsert = true,
        insert_prefix = "",
        term = {
            --  Position to open the terminal, this option is ignored if mode ~= term
            position = "bot",
            -- window size, this option is ignored if mode == tab
            size = 12,
        },
        float = {
            close_key = "<C-c>",
            -- Window border (see ':h nvim_open_win')
                    --• "none": No border (default).
                    --• "single": A single line box.
                    --• "double": A double line box.
                    --• "rounded": Like "single", but with rounded corners ("╭" etc.).
                    --• "solid": Adds padding by a single whitespace cell.
                    --• "shadow": A drop shadow effect by blending with the background.
            border = "rounded",
            -- Num from `0 - 1` for measurements
            height = 0.3,
            width = 0.8,
            x = 0,
            y = 0.92,

            -- Highlight group for floating window/border (see ':h winhl')
            border_hl = 'FloatBorder',
            float_hl = 'Normal',

            -- Transparency (see ':h winblend')
            blend = 0,
        },
        better_term = { -- Toggle mode replacement
            clean = false, -- Clean terminal before launch
            number = 10, -- Use nil for dynamic number and set init
            init = nil,
        },
        filetype_path = "",
        -- Execute before executing a file
        before_run_filetype = function()
            vim.cmd(":w")
        end,
        filetype = {
            javascript = "node",
            java = {
                "cd $dir &&",
                "javac $fileName &&",
                "java $fileNameWithoutExt",
            },
            c = {
                "cd $dir &&",
                "gcc $fileName",
                "-o $fileNameWithoutExt &&",
                "$dir/$fileNameWithoutExt",
            },
            cpp = {
                "cd $dir &&",
                "g++ $fileName",
                "-o $fileNameWithoutExt &&",
                "$dir/$fileNameWithoutExt",
            },
            python = python(),
            sh = "bash",
            rust = {
                "cd $dir &&",
                "rustc $fileName &&",
                "$dir/$fileNameWithoutExt",
            },
        },
        project_path = "",
        project      = {},
        prefix       = "",
    })
end
return M


