return {
    { 'MaximilianLloyd/ascii.nvim',lazy = true, dependencies = { 'MunifTanjim/nui.nvim', lazy = true } },
    {
        "goolord/alpha-nvim",
        event = "VimEnter",
        config = function()
            if vim.fn.argc() == 1 then
                return
            end

            local dashboard = require("alpha.themes.dashboard")

            --dashboard.section.header.val = vim.split(nvim_logo, "\n")
            dashboard.section.header.val = require('ascii').art.text.neovim.the_edge

            dashboard.section.buttons.val = {
                -- dashboard.button("S", "󰁯 " .. " Last session", [[:lua require("persistence").load({last = true}) <cr>]]),
                dashboard.button("n ", " " .. " New file", ":ene <BAR> startinsert <CR>"),
                dashboard.button("s ", " " .. " Current folder session", [[:lua require("persistence").load() <cr>]]),
                dashboard.button("r ", " " .. " Recent files", ":Telescope oldfiles <CR>"),
                dashboard.button("v ", " " .. " View change", ":DiffviewToggle <CR>"),
                dashboard.button("c ", " " .. " Config", ":Telescope file_browser path=$HOME/.config/nvim/lua<CR>"),
                dashboard.button("q ", " " .. " Quit", ":qa<CR>"),
                -- dashboard.button("t", " " .. " Find text", ":Telescope live_grep <CR>"),
                -- dashboard.button("f", " " .. " Find file", ":Telescope find_files <CR>"),
                -- dashboard.button("e", " " .. " Explore", ":Telescope file_browser<CR>"),
                -- dashboard.button("l", " 󰒲" .. " Lazy", ":Lazy<CR>"),
            }
            dashboard.opts.layout[1].val = #dashboard.section.buttons.val

            vim.api.nvim_create_autocmd("User", {
                pattern = "LazyVimStarted",
                callback = function()
                    local stats = require("lazy").stats()
                    local ms = (math.floor(stats.startuptime * 100 + 0.5) / 100)
                    local version = " "
                        .. vim.version().major
                        .. "."
                        .. vim.version().minor
                        .. "."
                        .. vim.version().patch
                    local plugins = "             " .. stats.count .. "plugins        " .. ms .. "ms"
                    os.setlocale("en_US.UTF-8")
                    local day = os.date("%Y/%m/%d")
                    local now = os.date("%H:%M")
                    local weekday = os.date("%A")
                    local datetime = " " .. day .. "         " .. now .. "            " .. weekday
                    
                    -- local datetime = os.date(" %Y/%m/%d        %H:%M            %a")
                    local footer = version .. plugins .. '\n \n'..datetime  .. "\n"
                    dashboard.section.footer.val = footer
                    pcall(vim.cmd.AlphaRedraw)
                end,
            })
            -- close Lazy and re-open when the dashboard is ready
            -- if vim.o.filetype == "lazy" then
            --     vim.cmd.close()
            --     vim.api.nvim_create_autocmd("User", {
            --         pattern = "AlphaReady",
            --         callback = function()
            --             require("lazy").show()
            --         end,
            --     })
            -- end
            require("alpha").setup(dashboard.config)
        end,
    },
    {
        'https://github.com/xiyaowong/transparent.nvim',
        lazy=false,
        event="VimEnter",
        enabled = true,
        config= function ()
            require("transparent").setup({ -- Optional, you don't have to run setup.
                groups = { -- table: default groups
                    'Normal',      'NormalNC',    'Comment',      'Constant',   'Special',      'Identifier',
                    'Statement',   'PreProc',     'Type',         'Underlined', 'Todo',         'String',
                    'Conditional', 'Repeat',      'Operator',     'Structure',  'LineNr',       'NonText',
                    'SignColumn',  'CursorLine',  'CursorLineNr', 'StatusLine', 'StatusLineNC',
                    'EndOfBuffer', "NormalFloat", "FloatBorder",  'Function',
                },
                -- table: additional groups that should be cleared
                extra_groups = {
                    "Folded",
                    "FoldColumn",
                    "UfoCursorFoldedLine",
                    "UfoFoldedBg",
                    "done_style",
                    "WarningMsg",
                    "group_style",
                    "icon_style"
                },
                -- table: groups you don't want to clear
                exclude_groups = {
                    "NotifyBackground",
                    'CursorLineNr',
                },
            })
            require('transparent').clear_prefix('lualine')
            
        end
    },

}
