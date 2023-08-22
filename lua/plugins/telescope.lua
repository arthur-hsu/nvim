local M = {
    'nvim-telescope/telescope.nvim',
    tag = '0.1.2',
    event="VeryLazy",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "debugloop/telescope-undo.nvim",
        "folke/noice.nvim",
        "nvim-telescope/telescope-file-browser.nvim",
        "nvim-telescope/telescope-project.nvim",
    }
}




function M.config()
    local builtin = require('telescope.builtin')
    vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
    vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})
    vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
    vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})
    vim.keymap.set('n', '<leader>fr', "<cmd>Telescope oldfiles<CR>", {})
    vim.keymap.set('n', '<leader>fp', "<cmd>lua require'telescope'.extensions.project.project{}<CR>", {})
    vim.api.nvim_set_keymap(
        "n",
        "<leader>fb",
        ":Telescope file_browser path=%:p:h select_buffer=true<CR>",
        { noremap = true }
    )


    require("telescope").setup({
        extensions = {
            file_browser = {
                theme = "ivy",
                -- disables netrw and use telescope-file-browser in its place
                hijack_netrw = true,
                mappings = {
                    ["i"] = {
                        -- your custom insert mode mappings
                    },
                    ["n"] = {
                        -- your custom normal mode mappings
                    },
                },
            },
            undo = {
                use_delta = true,
                use_custom_command = nil, -- setting this implies `use_delta = false`. Accepted format is: { "bash", "-c", "echo '$DIFF' | delta" }
                diff_context_lines = vim.o.scrolloff,
                entry_format = "state #$ID, $STAT, $TIME",
                time_format = "",
                --side_by_side = true,
                --layout_strategy = "vertical",
                --layout_config = {
                    --preview_height = 0.8,
                    --},
                    mappings = {
                    i = {
                        ["<C-cr>"] = require("telescope-undo.actions").yank_additions,
                        ["<S-cr>"] = require("telescope-undo.actions").yank_deletions,
                        ["<cr>"] = require("telescope-undo.actions").restore,
                    },
                    n = {
                        ["y"] = require("telescope-undo.actions").yank_additions,
                        ["Y"] = require("telescope-undo.actions").yank_deletions,
                        ["<cr>"] = require("telescope-undo.actions").restore,
                    },
                },
            },
        },
    })
    require("telescope").load_extension("undo")
    require("telescope").load_extension("noice")
    require("telescope").load_extension("file_browser")
    require('telescope').load_extension('project')
end
return M
