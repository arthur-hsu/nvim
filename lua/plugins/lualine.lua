--branch (git branch)
--buffers (shows currently available buffers)
--diagnostics (diagnostics count from your preferred source)
--diff (git diff status)
--encoding (file encoding)
--fileformat (file format)
--filename
--filesize
--filetype
--hostname
--location (location in file in line:column format)
--mode (vim mode)
--progress (%progress in file)
--searchcount (number of search matches when hlsearch is active)
--selectioncount (number of selected characters or lines)
--tabs (shows currently available tabs)
--windows (shows currently available windows)
local colors = {
    bg       = '#202328',
    fg       = '#bbc2cf',
    yellow   = '#ECBE7B',
    cyan     = '#008080',
    darkblue = '#081633',
    green    = '#88D97B',
    orange   = '#FF8800',
    violet   = '#a9a1e1',
    magenta  = '#c678dd',
    blue     = '#7FCEFF',
    red      = '#ec5f67',
}

local mode_color = {
    n = colors.blue,
    i = colors.green,
    v = colors.cyan,
    V = colors.cyan,
    c = colors.magenta,
    no = colors.red,
    s = colors.orange,
    S = colors.orange,
    [''] = colors.orange,
    ic = colors.yellow,
    R = colors.violet,
    Rv = colors.violet,
    cv = colors.red,
    ce = colors.red,
    r = colors.cyan,
    rm = colors.cyan,
    ['r?'] = colors.cyan,
    ['!'] = colors.red,
    t = colors.red,
}
local conditions = {
    buffer_not_empty = function()
        return vim.fn.empty(vim.fn.expand('%:t')) ~= 1
    end,
    hide_in_width = function()
        return vim.fn.winwidth(0) > 80
    end,
    check_git_workspace = function()
        local filepath = vim.fn.expand('%:p:h')
        local gitdir = vim.fn.finddir('.git', filepath .. ';')
        return gitdir and #gitdir > 0 and #gitdir < #filepath
    end,
}
local M = {
    'nvim-lualine/lualine.nvim',
    dependencies = {'nvim-tree/nvim-web-devicons'},
    event="VeryLazy",
}

function M.config()

    local lualine = require('lualine')
    local config = {
        options = {
            -- Disable sections and component separators
            disabled_filetypes = {     -- Filetypes to disable lualine for.
                statusline = {"NvimTree","diffpanel",'alpha'},      -- only ignores the ft for statusline.
                winbar = {"NvimTree","diffpanel",'alpha'},          -- only ignores the ft for winbar.
            },
            globalstatus = true,
            component_separators = '',
            section_separators = '',
            theme = {
                -- We are going to use lualine_c an lualine_x as left and
                -- right section. Both are highlighted by c theme .  So we
                -- are just setting default looks o statusline
                normal = { c = { fg = colors.fg, bg = "None" } },
                inactive = { c = { fg = colors.fg, bg = "None" } },
            },
        },
        sections = {
            -- these are to remove the defaults
            lualine_a = {},
            lualine_b = {},
            lualine_y = {},
            lualine_z = {},
            -- These will be filled later
            lualine_c = {},
            lualine_x = {},
        },
        inactive_sections = {
            -- these are to remove the defaults
            lualine_a = {},
            lualine_b = {},
            lualine_y = {},
            lualine_z = {},
            lualine_c = {},
            lualine_x = {},
        },
    }



    -- Inserts a component in lualine_c at left section
    local function ins_left(component)
        table.insert(config.sections.lualine_c, component)
    end

    -- Inserts a component in lualine_x at right section
    local function ins_right(component)
        table.insert(config.sections.lualine_x, component)
    end

    --ins_left {
        --function()
            --return '▊'
        --end,
        ----color = { fg = colors.blue }, -- Sets highlighting of component
        --color = function()
            ---- auto change color according to neovims mode
            --return { fg = mode_color[vim.fn.mode()],bg='None'  }
        --end,
        --padding = { left = 0, right = 1 }, -- We don't need space before this
    --}

    ins_left {
        -- mode component
        function()
            return ' '
        end,
        color = function()
            return { fg = mode_color[vim.fn.mode()],bg='None' }
        end,
        padding = { right = 1 },
    }

    ins_left{
        'mode',
        fmt = string.upper,
        color = function ()
            return{ fg = mode_color[vim.fn.mode()],gui = 'bold',bg='None' }
        end
    }


    --ins_left {
        --'filetype',
        ----fmt = string.upper,
        --icons_only = true,
        ----icons_enabled = true, -- I think icons are cool but Eviline doesn't have them. sigh
        --color = { fg = colors.yellow ,bg='None'},
    --}
    ins_left {
        'filename',
        color = { fg = colors.green, gui = 'bold',bg='None' },
        cond = conditions.buffer_not_empty,
    }

    ins_left { 'location', color = { fg = colors.yellow, bg='None' } }

    ins_left { 'progress', color = { fg = colors.yellow, bg='None' } }



    -- Insert mid section. You can make any number of sections in neovim :)
    -- for lualine it's any number greater then 2
    ins_left {
        function()
            return '%='
        end,
    }

    ins_left {
        -- Lsp server name .
        function()
            local msg = 'No Active Lsp'
            local buf_ft = vim.api.nvim_buf_get_option(0, 'filetype')
            local clients = vim.lsp.get_active_clients()
            if next(clients) == nil then
                return msg
            end
            for _, client in ipairs(clients) do
                local filetypes = client.config.filetypes
                if filetypes and vim.fn.index(filetypes, buf_ft) ~= -1 then
                    return client.name
                end
            end
            return msg
        end,
        icon = ' ',
        color = function()
            return { fg = mode_color[vim.fn.mode()],gui = 'bold',bg='None' }
        end,
    }

    ins_right {
        'diagnostics',
        sources = { 'nvim_diagnostic' },
        symbols = {
            error = " ",
            warn  = " ",
            info  = " ",
            hint  = "󰝶 ",
        },
        diagnostics_color = {
            color_error = { fg = colors.red,bg='None' },
            color_warn = { fg = colors.yellow,bg='None' },
            color_info = { fg = colors.cyan,bg='None' },
            color_hint = { fg = colors.fg,bg='None' },
        },
    }

    ins_right {
        'diff',
        -- Is it me or the symbol for modified us really weird
        --symbols = { added = ' ', modified = '󰝤 ', removed = ' ' },
        diff_color = {
            added = { fg = colors.green,bg='None' },
            modified = { fg = colors.yellow,bg='None' },
            removed = { fg = colors.red,bg='None' },
        },
        cond = conditions.hide_in_width,
    }
    -- Add components to right sections
    ins_right {
        'o:encoding', -- option component same as &encoding in viml
        fmt = string.upper, -- I'm not sure why it's upper case either ;)
        cond = conditions.hide_in_width,
        color = { fg = colors.yellow, gui = 'bold',bg='None' },
    }
    ins_right{
        function ()
            return require("lazy.status").updates
        end,
        cond = require("lazy.status").has_updates,
        color = { fg = colors.green },
    }

    local os = vim.loop.os_uname().sysname
    if os == "Linux" then
        os = io.popen("lsb_release -i -s"):read("*l")
    end
    ins_right {
        function ()
            local os_icons ={
                ["Windows"]= '',
                ["Darwin"] = '',
                --["Linux"]  = '',
                ["Debian"] = '',
                ["Ubuntu"] = ''
            }
            return os_icons[os]
        end,
        color = function ()
            local os_color = {
                ["Windows"] = {fg = "#087CD5", bg='None'},
                ["Darwin"]  = {fg = "#A9B3B9", bg='None'},
                ["Debian"]  = {fg = "#88D97B", bg='None'},
                ["Ubuntu"]  = {fg = "#DD4814", bg='None'},
            }
            return os_color[os]
        end
    }


    ins_right {
        'branch',
        icon = '',
        color = { fg = colors.magenta, gui = 'bold',bg='None' },
    }

    local status = require("copilot.api").status.data
    ins_right{
        function ()
            local copilot_status = {
                [""] = ' ',
                ["Normal"] = ' ',
                ["Warning"] = ' ',
                ["InProgress"] = ' ',
                ["Error"] = ' ',
            }
            return copilot_status[status.status] .. (status.message or "")
        end,
        color = function ()
            local copilot_colours = {
                [""] = { fg = '#00f4ff', bg = 'None' },
                ["Normal"] = { fg = '#00f4ff',bg = 'None' },
                ["Warning"] = { fg = colors.orange, bg = 'None' },
                ["InProgress"] = { fg = colors.yellow, bg = 'None' },
                ["Error"] = { fg = colors.yellow, bg = 'None' },
            }
            return copilot_colours[status.status]
        end

    }
    --ins_right {
        --function()
            --return '▊'
            ----return ''
        --end,
        --color = function()
            ---- auto change color according to neovims mode
            --return { fg = mode_color[vim.fn.mode()], bg='None' }
        --end,
        --padding = { left = 1 },
    --}

    -- Now don't forget to initialize lualine
    lualine.setup(config)
end
return M
