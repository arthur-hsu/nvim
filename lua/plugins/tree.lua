local M = {
    'nvim-tree/nvim-tree.lua',
    dependencies = {'nvim-tree/nvim-web-devicons'},
    event="VeryLazy",
    -- event="VimEnter",
}



function M.config()
    -- disable netrw at the very start of your init.lua
    vim.g.loaded_netrw = 1
    vim.g.loaded_netrwPlugin = 1

    local function my_on_attach(bufnr)
    local api = require('nvim-tree.api')

    local function opts(desc)
        return { desc = 'nvim-tree: ' .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
    end
    vim.keymap.set('n', '<C-l>', api.node.open.vertical,                opts('Open: Vertical Split'))
    vim.keymap.set('n', 'cd', api.tree.change_root_to_node,          opts('CD'))
    end
    -- always open nvim-tree
    local function open_nvim_tree(data)
        -- buffer is a real file on the disk
        local real_file = vim.fn.filereadable(data.file) == 1

        -- buffer is a [No Name]
        local no_name = data.file == '' and vim.bo[data.buf].buftype == ''

        if not real_file and not no_name then
            return
        end
    end

    require("nvim-tree").setup { -- BEGIN_DEFAULT_OPTS
        on_attach = my_on_attach,
        auto_close = true,
        hijack_cursor = true,
        sync_root_with_cwd = true,
        renderer = {
            add_trailing = false,
            group_empty = false,
            highlight_git = false,
            full_name = false,
            highlight_opened_files = "none",
            highlight_modified = "none",
            root_folder_label = ":~:s?$?/..?",
            indent_width = 2,
            indent_markers = {
                enable = true,
                inline_arrows = true,
                icons = {
                    corner = "└",
                    edge = "│",
                    item = "│",
                    bottom = "─",
                    none = " ",
                },
            },
            icons = {
                show = {
                    file = true,
                    folder = true,
                    folder_arrow = false,
                    git = true,
                    modified = true,
                },
                glyphs = {
                    default = "",
                    symlink = "",
                    bookmark = "󰆤",
                    modified = "●",
                    folder = {
                        arrow_closed = "",
                        arrow_open = "",
                        default = "",
                        open = "",
                        empty = "",
                        empty_open = "",
                        symlink = "",
                        symlink_open = "",
                    },
                    git = {
                        unstaged = "✗",
                        staged = "✓",
                        unmerged = "",
                        renamed = "➜",
                        untracked = "★",
                        deleted = "",
                        ignored = "◌",
                    },
                },
            },
        },
        diagnostics = {
            icons = {
                hint = "",
                info = "",
                warning = "",
                error = "",
            },
        },
        actions = {
            open_file = {
                quit_on_open = true,
            },
        },
    }
end
return M


