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

local function _git_root()
    local git_root = vim.fs.find(".git", { upward = true, type = "directory" })[1]
    if git_root then
        git_root = vim.fs.dirname(git_root)
        return git_root
    else
        return vim.fn.getcwd()
    end
end

return {
    'nvim-telescope/telescope.nvim',
    event = "VeryLazy",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "debugloop/telescope-undo.nvim",
        "nvim-telescope/telescope-file-browser.nvim",
        -- "tsakirist/telescope-lazy.nvim"
        -- "nvim-telescope/telescope-project.nvim",
    },
    opts = function ()
        local actions    = require("telescope.actions")
        local fb_actions = require "telescope._extensions.file_browser.actions"

        return {
            defaults = {
                mappings = {
                    i = {
                        ["<A-s>"] = flash,
                    },
                    n = {
                        ["A-s"] = flash,
                        ["<C-c>"] = actions.close
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
                            ["<C-o>"] = fb_actions.open,
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
        }
    end,
    keys = {
        { "<leader>fb", "<cmd>Telescope file_browser path=%:p:help select_buffer=true<cr>", desc = "Open Buffer",      mode = { "n" } },
        { "<leader>ff", "<cmd>Telescope find_files<cr>",                                    desc = "Find File",        mode = { "n" } },
        {
            "<leader>fF",
            function ()
                local git_root = _git_root()
                require('telescope.builtin').find_files({
                    prompt_title = 'Find File in ' .. git_root,
                    cwd = git_root,
                })
            end,
            desc = "Find File in Git Root",
            mode = { "n" },
        },
        { "<leader>fg", "<cmd>Telescope live_grep<cr>",                                     desc = "Grep File",        mode = { "n" } },
        {
            "<leader>fG",
            function ()
                local git_root = _git_root()
                require('telescope.builtin').live_grep({
                    prompt_title = 'Grep File in ' .. git_root,
                    cwd = git_root,
                })
            end,
            desc = "Grep File in Git Root",
            mode = { "n" }
        },
        { "<leader>fh", "<cmd>Telescope help_tags<cr>",                                     desc = "Help Tags",        mode = { "n" } },
        { "<leader>fn", "<cmd>enew<cr>",                                                    desc = "New File",         mode = { "n" } },
        { "<leader>fr", "<cmd>Telescope oldfiles<cr>",                                      desc = "Open Recent File", mode = { "n" } },
    },
    config = function (_, opts)

        require("telescope").setup(opts)
        require("telescope").load_extension("undo")
        require("telescope").load_extension("file_browser")
        -- require("telescope").load_extension("lazy")
        -- require('telescope').load_extension('project')
    end
}
