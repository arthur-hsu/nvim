local M = {
    'https://github.com/nvimdev/lspsaga.nvim',
    lazy = true,
    enabled = true,
    --enevt = "InsertEnter",
    event = { "BufReadPost", "BufNewFile" },
    dependencies = {
        'nvim-treesitter/nvim-treesitter', -- optional
        'nvim-tree/nvim-web-devicons'      -- optional
    }
}

function M.config()
    require('lspsaga').setup({
        ui = {
            border = 'rounded',
            devicon = true,
            title = true,
            expand = '󰅂',
            collapse = '󰅀',
            code_action = '💡',
            actionfix = ' ',
            -- lines = { '┗', '┣', '┃', '━', '┏' },
            lines = { '╰', '├', '│', '─', '╭' },
            kind = nil,
            imp_sign = '󰳛 ',
        },
        hover = {
            max_width = 0.9,
            max_height = 0.8,
            open_link = 'gx',
            open_cmd = '!edge',
        },
        diagnostic = {
            show_code_action = true,
            show_layout = 'float',
            show_normal_height = 10,
            jump_num_shortcut = true,
            max_width = 0.8,
            max_height = 0.6,
            max_show_width = 0.9,
            max_show_height = 0.6,
            text_hl_follow = true,
            border_follow = true,
            extend_relatedInformation = false,
            diagnostic_only_current = false,
            keys = {
                exec_action = 'o',
                quit = 'q',
                toggle_or_jump = '<CR>',
                quit_in_show = { 'q', '<ESC>' },
            },
        },
        code_action = {
            num_shortcut = true,
            show_server_name = false,
            extend_gitsigns = true,
            max_height = 0.3,
            keys = {
                quit = 'q',
                exec = '<CR>',
            },
        },
        lightbulb = {
            enable = false,
            sign = false,
            debounce = 10,
            sign_priority = 40,
            virtual_text = true,
            enable_in_insert = false,
        },
        scroll_preview = {
            scroll_down = '<C-f>',
            scroll_up = '<C-b>',
        },
        request_timeout = 2000,

        finder = {
            max_height = 0.5,
            left_width = 0.3,
            right_width = 0.5,
            methods = {},
            default = 'ref+imp',
            layout = 'float',
            silent = false,
            filter = {},
            sp_inexist = false,
            keys = {
                shuttle = '[w',
                toggle_or_open = 'o',
                vsplit = 's',
                split = 'i',
                tabe = 't',
                tabnew = 'r',
                quit = 'q',
                close = '<C-c>k',
            },
        },
        definition = {
            width = 0.6,
            height = 0.5,
            keys = {
                edit = '<C-c>o',
                vsplit = '<C-l>',
                split = '<C-x>',
                tabe = '<C-t>',
                quit = 'q',
                close = '<C-c>k',
            },
        },
        rename = {
            in_select = true,
            auto_save = false,
            project_max_width = 0.5,
            project_max_height = 0.5,
            keys = {
                quit = '<C-q>',
                exec = '<CR>',
                select = 'x',
            },
        },
        symbol_in_winbar = {
            enable = true,
            separator = '› ',
            hide_keyword = false,
            show_file = true,
            folder_level = 1,
            color_mode = true,
            dely = 300,
        },
        outline = {
            win_position = 'right',
            win_width = 30,
            auto_preview = true,
            detail = true,
            auto_close = true,
            close_after_jump = true,
            layout = 'float', -- float or normal
            max_height = 0.5,
            left_width = 0.3,
            keys = {
                toggle_or_jump = '<CR>',
                quit = 'q',
                jump = 'g',
            },
        },
        callhierarchy = {
            layout = 'float',
            keys = {
                edit = 'e',
                vsplit = 's',
                split = 'i',
                tabe = 't',
                close = 'C-c>k',
                quit = 'q',
                shuttle = '[w',
                toggle_or_req = 'u',
            },
        },
        implement = {
            enable = true,
            sign = true,
            lang = {},
            virtual_text = true,
            priority = 100,
        },
        beacon = {
            enable = true,
            frequency = 7,
        },
    })
end

return M
