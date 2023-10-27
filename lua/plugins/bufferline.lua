local M = {
    'akinsho/bufferline.nvim',
    dependencies = {'nvim-tree/nvim-web-devicons'},
    event="VeryLazy",
}

function M.config()
    local bufferline = require('bufferline')
    bufferline.setup({
        options = {
            mode = "buffers", -- set to "tabs" to only show tabpages instead
            style_preset = bufferline.style_preset.default, -- or bufferline.style_preset.minimal
            -- style_preset = {
            --     --bufferline.style_preset.no_italic,
            --     --bufferline.style_preset.no_bold
            -- },
            separator_style = 'thin',           -- "slant" | "slope" | "thick" | "thin" | { 'any', 'any' }
            themable = true,
            close_command = "bdelete! %d",       -- can be a string | function, | false see "Mouse actions"
            right_mouse_command = "bdelete! %d", -- can be a string | function  | false, see "Mouse actions"
            left_mouse_command = "buffer %d",    -- can be a string | function, | false see "Mouse actions"
            middle_mouse_command = "vertical sbuffer %d",          -- can be a string | function, | false see "Mouse actions"
            indicator = {
                icon = '▎', -- this should be omitted if indicator style is not 'icon'
                style = 'icon',
            },
            -- hover = {
            --     enabled = true,
            --     delay = 200,
            --     reveal = {'close'}
            -- },
            buffer_close_icon = '󰅖',
            modified_icon = '●',
            close_icon = '',
            left_trunc_marker = '',
            right_trunc_marker = '',
            color_icons = true,
            get_element_icon = function(element)
                local icon, hl = require('nvim-web-devicons').get_icon_by_filetype(element.filetype, { default = false })
                return icon, hl
            end,
            show_buffer_icons = true,
            show_buffer_close_icons = true,
            show_close_icon = true,
            show_tab_indicators = true,
            show_duplicate_prefix = true,
            persist_buffer_sort = true,
            move_wraps_at_ends = false,
            offsets = {
                {
                    filetype = "NvimTree",
                    text = function ()
                        return vim.fn.fnamemodify(vim.fn.getcwd(), ':t')
                    end,
                    highlight = "Directory",
                    text_align = "center",
                    separator = true
                }
            },
            highlights = {
            }
        }
    })
    vim.g.transparent_groups = vim.list_extend(
        vim.g.transparent_groups or {},
        vim.tbl_map(function(v)
            return v.hl_group
        end, vim.tbl_values(require('bufferline.config').highlights))
    )

end
return M
