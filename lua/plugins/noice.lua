local M = {
    "folke/noice.nvim",
    enabled = true,
    dependencies = {
        'nvim-tree/nvim-web-devicons',
        "MunifTanjim/nui.nvim",
        {
            "rcarriga/nvim-notify",
            events = "VeryLazy",
            opts = {
                background_colour = "NotifyBackground",
                fps = 60,
                level = vim.log.levels.INFO,
                -- level = 2,
                --minimum_width = 50,
                -- Built-in renderers:
                -- "default" "minimal" "simple" "compact" "wrapped-compact"
                -- max_width = 200,
                -- max_height = 10,

                render = "default",
                time_formats = {
                    notification = "%T",
                    notification_history = "%FT%T"
                },
                stages = "fade_in_slide_out",
                -- stages = "fade",
                -- stages = 'static',
                timeout = 300,
                top_down = true
            }
        },
        {
            'mrded/nvim-lsp-notify',
            dependencies = { 'rcarriga/nvim-notify' },
            opts = {
                icons = {
                    spinner = { "⣷" , "⣯", "⣟", "⡿", "⢿", "⣻", "⣽", "⣾" },
                    done    = "✓"
                }
            },
            config = function(_, opts)
                opts.notify = require("notify")
                require("lsp-notify").setup(opts)
            end
        },
        {
            "smjonas/inc-rename.nvim",
            config = function()
                require("inc_rename").setup()
                vim.keymap.set("n", "<space>rn", function()
                    return ":IncRename " .. vim.fn.expand("<cword>")
                end, { expr = true })
            end,
        }

    },
    event="VeryLazy",
}

function M.config()
    require("noice").setup(
    {
        background_colour = "#000000",
        ---"@type NoicePresets"
        presets = {
            -- you can enable a preset by setting it to true, or a table that will override the preset config
            -- you can also add custom presets that you can enable/disable with enabled=true
            command_palette       = true, -- position the cmdline and popupmenu together
            lsp_doc_border        = true, -- add a border to hover docs and signature help
            bottom_search         = false, -- use a classic bottom cmdline for search
            long_message_to_split = false, -- long messages will be sent to a split
            inc_rename            = true, -- enables an input dialog for inc-rename.nvim
        },
        cmdline = {
            enabled = true, -- enables the Noice cmdline UI
            view = "cmdline_popup", -- view for rendering the cmdline. Change to `cmdline` to get a classic cmdline at the bottom
            format = {
                cmdline     = { pattern = "^:", icon = " ", lang = "vim" },
                search_down = { kind = "search", pattern = "^/", icon = " ", lang = "regex" },
                search_up   = { kind = "search", pattern = "^%?", icon = " ", lang = "regex" },
            },
            opts = {}, -- global options for the cmdline. See section on views
            ---"@type table<string, CmdlineFormat>"
        },
        messages = {
            --------------------------------------------------------------------------------
            --View             Backend    Description
            ---------------- ---------- ----------------------------------------------------
            --notify           notify     nvim-notify with level=nil, replace=false, merge=false
            --split            split      horizontal split
            --vsplit           split      vertical split
            --popup            popup      simple popup
            --mini             mini       minimal view, by default bottom right, right-aligned
            --cmdline          popup      bottom line, similar to the classic cmdline
            --cmdline_popup    popup      fancy cmdline popup, with different styles according to the cmdline mode
            --cmdline_output   split      split used by config.presets.cmdline_output_to_split
            --messages         split      split used for :messages
            --confirm          popup      popup used for confirm events
            --hover            popup      popup used for lsp signature help and hover
            --popupmenu        nui.menu   special view with the options used to render the popupmenu when backend is nui
            --------------------------------------------------------------------------------
            -- NOTE: If you enable messages, then the cmdline is enabled automatically.
            -- This is a current Neovim limitation.
            enabled      = true, -- enables the Noice messages UI
            view         = "notify", -- default view for messages
            view_error   = "notify", -- view for errors
            view_warn    = "notify", -- view for warnings
            view_history = "popup", -- view for :messages
            view_search  = "virtualtext", -- view for search count messages. Set to `false` to disable
        },
        popupmenu = {
            enabled = true, -- enables the Noice popupmenu UI
            ---@type 'nui'|'cmp'
            backend = "cmp", -- backend to use to show regular cmdline completions
            ---@type "NoicePopupmenuItemKind|false"
            -- Icons for completion item kinds (see defaults at noice.config.icons.kinds)
            --kind_icons = true, -- set to `false` to disable icons
        },
        -- default options for require('noice').redirect
        -- see the section on Command Redirection
        ---@type "NoiceRouteConfig"
        redirect = {
            view = "popup",
            filter = { event = "msg_show" },
        },
        smart_move = {
            -- noice tries to move out of the way of existing floating windows.
            enabled = true, -- you can disable this behaviour here
            -- add any filetypes here, that shouldn't trigger smart move.
            excluded_filetypes = { "cmp_menu", "cmp_docs", "notify" },
        },
        notify = {
            -- Noice can be used as `vim.notify` so you can route any notification like other messages
            -- Notification messages have their level and other properties set.
            -- event is always "notify" and kind can be any log level as a string
            -- The default routes will forward notifications to nvim-notify
            -- Benefit of using Noice for this is the routing and consistent history view
            enabled = true,
            view = "notify",
        },
        lsp = {
            progress = {
                enabled = false,
                -- Lsp Progress is formatted using the builtins for lsp_progress. See config.format.builtin
                -- See the section on formatting for more details on how to customize.
                --- "@type NoiceFormat|string"
                format = "lsp_progress",
                --- "@type NoiceFormat|string"
                format_done = "lsp_progress_done",
                throttle = 1000 / 30, -- frequency to update lsp progress message
                view = "mini",
            },
            override = {
                ["vim.lsp.util.convert_input_to_markdown_lines"] = true, -- override the default lsp markdown formatter with Noice
                ["vim.lsp.util.stylize_markdown"]                = true, -- override the lsp markdown formatter with Noice
                ["cmp.entry.get_documentation"]                  = true, -- override cmp documentation with Noice (needs the other options to work)
            },
            hover = {
                enabled = true,
                silent = true, -- set to true to not show a message if hover is not available
                view = nil, -- when nil, use defaults from documentation
                ---"@type NoiceViewOptions"
                opts = {}, -- merged with defaults from documentation
            },
            signature = {
                enabled = true,
                auto_open = {
                    enabled  = true,
                    trigger  = true,  -- Automatically show signature help when typing a trigger character from the LSP
                    luasnip  = true, -- Will open signature help when jumping to Luasnip insert nodes
                    throttle = 50,    -- Debounce lsp signature help request by 50ms
                },
                view = nil, -- when nil, use defaults from documentation
                ---"@type NoiceViewOptions"
                opts = {}, -- merged with defaults from documentation
            },
            message = {
                -- Messages shown by lsp servers
                enabled = true,
                view    = "mini",
                opts    = {},
            },
            -- defaults for hover and signature help
            documentation = {
                view = "hover",
                ---"@type NoiceViewOptions"
                opts = {
                    lang        = "markdown",
                    replace     = true,
                    render      = "plain",
                    format      = { "{message}" },
                    win_options = { concealcursor = "n", conceallevel = 3 },
                },
            },
        },
        markdown = {
            hover = {
                ["|(%S-)|"] = vim.cmd.help, -- vim help links
                ["%[.-%]%((%S-)%)"] = require("noice.util").open, -- markdown links
            },
            highlights = {
                ["|%S-|"] = "@text.reference",
                ["@%S+"] = "@parameter",
                ["^%s*(Parameters:)"] = "@text.title",
                ["^%s*(Return:)"] = "@text.title",
                ["^%s*(See also:)"] = "@text.title",
                ["{%S-}"] = "@parameter",
            },
        },
        throttle = 1000 / 30, -- how frequently does Noice need to check for ui updates? This has no effect when in blocking mode.
        ---"@type NoiceConfigViews"
        ---@see section on views

        views = {
            -- notify = { replace = true },
        },
        ---"@type NoiceRouteConfig[]"
        routes = { --- @see section on routes
            {
                filter = {
                    event = "msg_show",
                    kind  = "",
                    find  = "written",
                },
                opts = { skip = true },
            },
        },
        ---"@type table<string, NoiceFilter>"
        status = {}, --- @see section on statusline components
        ---"@type NoiceFormatOptions"
    })
    vim.keymap.set({"n", "i", "s"}, "<c-f>", function()
        if not require("noice.lsp").scroll(4) then
            return "<c-f>"
        end
    end, { silent = true, expr = true })

    vim.keymap.set({"n", "i", "s"}, "<c-b>", function()
        if not require("noice.lsp").scroll(-4) then
            return "<c-b>"
        end
    end, { silent = true, expr = true })
    require("telescope").load_extension("noice")

end
return M
