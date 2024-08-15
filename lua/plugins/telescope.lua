return {
    'nvim-telescope/telescope.nvim',
    event = "VeryLazy",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "debugloop/telescope-undo.nvim",
        -- "folke/noice.nvim",
        "nvim-telescope/telescope-file-browser.nvim",
        -- "tsakirist/telescope-lazy.nvim"
        -- "nvim-telescope/telescope-project.nvim",
    },
    config = function ()
        -- Enable Flash extension for telescope
        local function flash(prompt_bufnr)
            require("flash").jump({
                pattern = "^",
                label = { after = { 0, 0 } },
                search = {
                    mode = "search",
                    exclude = {
                        function(win)
                            return vim.bo[vim.api.nvim_win_get_buf(win)].filetype ~= "TelescopeResults"
                        end,
                    },
                },
                action = function(match)
                    local picker = require("telescope.actions.state").get_current_picker(prompt_bufnr)
                    picker:set_selection(match.pos[1] - 1)
                end,
            })
        end
        local wk = require("which-key")
        wk.add(
            {
                { "<leader>f", group = "find" },
                { "<leader>fb", "<cmd>Telescope file_browser path=%:p:help select_buffer=true<cr>", desc = "Open Buffer" },
                { "<leader>ff", "<cmd>Telescope find_files<cr>", desc = "Find File" },
                { "<leader>fg", "<cmd>Telescope live_grep<cr>", desc = "Grep File" },
                { "<leader>fh", "<cmd>Telescope help_tags<cr>", desc = "Help Tags" },
                { "<leader>fn", "<cmd>enew<cr>", desc = "New File" },
                { "<leader>fr", "<cmd>Telescope oldfiles<cr>", desc = "Open Recent File" },
            }
        )

        local actions    = require("telescope.actions")
        local fb_actions = require "telescope._extensions.file_browser.actions"

        require("telescope").setup({
            defaults = {
                mappings = {
                    i = {
                        ["<A-s>"] = flash,
                    },
                    n = {
                        ["s"] = flash
                    },
                },
                layout_strategy = "flex",
                layout_config = {
                    horizontal = {
                        height          = 0.7,
                        preview_cutoff  = 10,
                        prompt_position = "bottom",
                        width           = 0.9,
                        preview_width   = 0.6
                    },
                    vertical = {
                        height          = 0.9,
                        preview_cutoff  = 10,
                        prompt_position = "bottom",
                        width           = 0.8,
                        preview_height  = 0.6,
                    },
                },
                scroll_strategy       = "limit",
                -- initial_mode          = "normal", --normal
                initial_mode          = "insert", --normal
                prompt_prefix         = "➤  ",
                -- path_display       = { "tail" },
                path_display          = { "smart" },
                dynamic_preview_title = true,
                -- path_display = function(opts, path)
                    --   local tail = require("telescope.utils").path_tail(path)
                    --   return string.format("%s (%s)", tail, path)
                    -- end,
                    vimgrep_arguments = {
                        "rg",
                        "--hidden",
                        "--color=never",
                        "--no-heading",
                        "--with-filename",
                        "--line-number",
                        "--column",
                        "--smart-case",
                        -- "--colors 'match:fg:169,169,169'"
                    },
                    file_ignore_patterns = {
                        "node_modules",
                        ".git",
                        ".cache",
                        ".resx",
                        "__pychace__",
                        ".pytest_cache"
                    },
                },
            extensions = {
                file_browser = {
                    theme = "ivy",
                    -- disables netrw and use telescope-file-browser in its place
                    hijack_netrw = true,
                    mappings = {
                        ["i"] = {
                            -- your custom insert mode mappings
                            --["<A-c>"] = fb_actions.create,
                            --["<S-CR>"] = fb_actions.create_from_prompt,
                            --["<A-r>"] = fb_actions.rename,
                            --["<A-m>"] = fb_actions.move,
                            --["<A-y>"] = fb_actions.copy,
                            --["<A-d>"] = fb_actions.remove,
                            ["<C-o>"] = fb_actions.open,
                            --["<C-g>"] = fb_actions.goto_parent_dir,
                            --["<C-e>"] = fb_actions.goto_home_dir,
                            --["<C-w>"] = fb_actions.goto_cwd,
                            --["<C-t>"] = fb_actions.change_cwd,
                            --["<C-f>"] = fb_actions.toggle_browser,
                            --["<C-h>"] = fb_actions.toggle_hidden,
                            --["<C-s>"] = fb_actions.toggle_all,
                            --["<bs>"] = fb_actions.backspace,
                            -- ["<C-?>"] = fb_actions.help,
                        },
                        ["n"] = {
                            -- your custom normal mode mappings
                            --["c"] = fb_actions.create,
                            --["r"] = fb_actions.rename,
                            --["m"] = fb_actions.move,
                            --["y"] = fb_actions.copy,
                            --["d"] = fb_actions.remove,
                            --["o"] = fb_actions.open,
                            --["g"] = fb_actions.goto_parent_dir,
                            --["e"] = fb_actions.goto_home_dir,
                            --["w"] = fb_actions.goto_cwd,
                            --["t"] = fb_actions.change_cwd,
                            --["f"] = fb_actions.toggle_browser,
                            --["h"] = fb_actions.toggle_hidden,
                            --["s"] = fb_actions.toggle_all,
                        },
                    },
                },
                undo = {
                    use_delta          = true,
                    use_custom_command = nil, -- setting this implies `use_delta = false`. Accepted format is: { "bash", "-c", "echo '$DIFF' | delta" }
                    -- diff_context_lines = vim.o.scrolloff,
                    vim_diff_opts = { ctxlen = 4 },
                    entry_format       = "state #$ID, $STAT, $TIME",
                    time_format        = "",
                    --side_by_side     = true,
                    --layout_strategy  = "vertical",
                    --layout_config = {
                        --preview_height = 0.8,
                        --},
                    mappings = {
                        i = {
                            ["<C-cr>"] = require("telescope-undo.actions").yank_additions,
                            ["<S-cr>"] = require("telescope-undo.actions").yank_deletions,
                            ["<cr>"]   = require("telescope-undo.actions").restore,
                        },
                        n = {
                            ["y"]    = require("telescope-undo.actions").yank_additions,
                            ["Y"]    = require("telescope-undo.actions").yank_deletions,
                            ["<cr>"] = require("telescope-undo.actions").restore,
                        },
                    },
                },
            },
        })
        require("telescope").load_extension("undo")
        require("telescope").load_extension("file_browser")
        -- require("telescope").load_extension("lazy")
        -- require('telescope').load_extension('project')
    end
}

