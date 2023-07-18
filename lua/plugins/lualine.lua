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
local M = {
    'nvim-lualine/lualine.nvim',
    dependencies = {'nvim-tree/nvim-web-devicons'},
    event="VeryLazy",
}

function M.config()
    require('lualine').setup {
        options = {
            theme = 'codedark',
            disabled_filetypes = {     -- Filetypes to disable lualine for.
                statusline = {"NvimTree","diffpanel"},       -- only ignores the ft for statusline.
                winbar = {"NvimTree","diffpanel"},                     -- only ignores the ft for winbar.
            },
        },
        globalstatus = true,
        sections = {
            lualine_a = {
                {'mode',
                    icons_enabled = true, -- Enables the display of icons alongside the component.
                    icon = nil,
                },
            },
            lualine_b = {
                { 'diff',
                    colored = true, -- Displays a colored diff status if set to true
                    diff_color = {
                        -- Same color values as the general color option can be used here.
                        added    = 'DiffAdd',    -- Changes the diff's added color
                        modified = 'DiffChange', -- Changes the diff's modified color
                        removed  = 'DiffDelete', -- Changes the diff's removed color you
                    },
                    symbols = {added = '+', modified = '~', removed = '-'}, -- Changes the symbols used by the diff.
                    source = nil, -- A function that works as a data source for diff.
                            -- It must return a table as such:
                            --   { added = add_count, modified = modified_count, removed = removed_count }
                            -- or nil on failure. count <= 0 won't be displayed.
                },
                {'branch',
                    icon = {'', color={fg='LightYellow'}}
                },
            },
            lualine_c = {
                {'filename',
                    file_status = true,        -- Displays file status (readonly status, modified status)
                    shorting_target = 40,
                    symbols = {
                        modified = '[+]',      -- Text to show when the file is modified.
                        readonly = '[-]',      -- Text to show when the file is non-modifiable or readonly.
                        unnamed = '[No Name]', -- Text to show for unnamed buffers.
                        newfile = '[New]',     -- Text to show for newly created file before first written
                }
                },
            },
            lualine_x = {
                {'encoding',
                colored = true},
                --{'fileformat',
                    --colored = true,
                    --icons_enabled = true},
                {'filetype',
                    colored = true,
                    icons_enabled = true},
            },
            lualine_y = {
                {'diagnostics',
                -- Table of diagnostic sources, available sources are:
                --   'nvim_lsp', 'nvim_diagnostic', 'nvim_workspace_diagnostic', 'coc', 'ale', 'vim_lsp'.
                    sources = {'nvim_lsp'},
                    symbols = {error = '✘ ', warn = '▲ ', hint = '⚑ ', info = ' '},
                    colored = true, -- Displays a colored diff status if set to true
                    icons_enabled = true,
                },
                {'progress',
                    colored = true},
            },
            lualine_z = {
                {'location',
                    colored = true},
            }
        }
    }
end
return M
