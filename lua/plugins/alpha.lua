return {
    "goolord/alpha-nvim",
    lazy = false,
    event = "VimEnter",
    dependencies = {
        "nvim-tree/nvim-web-devicons",
        { 'MaximilianLloyd/ascii.nvim', dependencies = { 'MunifTanjim/nui.nvim' } },
    },
    --lazy = false,
    opts = function()
        local dashboard = require("alpha.themes.dashboard")
        local logo = [[
           ▄ ▄
       ▄   ▄▄▄     ▄ ▄▄▄ ▄ ▄
       █ ▄ █▄█ ▄▄▄ █ █▄█ █ █
    ▄▄ █▄█▄▄▄█ █▄█▄█▄▄█▄▄█ █
  ▄ █▄▄█ ▄ ▄▄ ▄█ ▄▄▄▄▄▄▄▄▄▄▄▄▄▄
  █▄▄▄▄ ▄▄▄ █ ▄ ▄▄▄ ▄ ▄▄▄ ▄ ▄ █ ▄
▄ █ █▄█ █▄█ █ █ █▄█ █ █▄█ ▄▄▄ █ █
█▄█ ▄ █▄▄█▄▄█ █ ▄▄█ █ ▄ █ █▄█▄█ █
    █▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄█ █▄█▄▄▄█
]]
        local arthur_1 = [[
 ▄▄▄       ██▀███  ▄▄▄█████▓ ██░ ██  █    ██  ██▀███  
▒████▄    ▓██ ▒ ██▒▓  ██▒ ▓▒▓██░ ██▒ ██  ▓██▒▓██ ▒ ██▒
▒██  ▀█▄  ▓██ ░▄█ ▒▒ ▓██░ ▒░▒██▀▀██░▓██  ▒██░▓██ ░▄█ ▒
░██▄▄▄▄██ ▒██▀▀█▄  ░ ▓██▓ ░ ░▓█ ░██ ▓▓█  ░██░▒██▀▀█▄  
 ▓█   ▓██▒░██▓ ▒██▒  ▒██▒ ░ ░▓█▒░██▓▒▒█████▓ ░██▓ ▒██▒
 ▒▒   ▓▒█░░ ▒▓ ░▒▓░  ▒ ░░    ▒ ░░▒░▒░▒▓▒ ▒ ▒ ░ ▒▓ ░▒▓░
  ▒   ▒▒ ░  ░▒ ░ ▒░    ░     ▒ ░▒░ ░░░▒░ ░ ░   ░▒ ░ ▒░
  ░   ▒     ░░   ░   ░       ░  ░░ ░ ░░░ ░ ░   ░░   ░ 
      ░  ░   ░               ░  ░  ░   ░        ░     
        ]]

        --dashboard.section.header.val = vim.split(nvim_logo, "\n")
        dashboard.section.header.val = require('ascii').art.text.neovim.the_edge
        
        dashboard.section.buttons.val = {
            dashboard.button("f", " " .. " Find file", ":Telescope find_files <CR>"),
            dashboard.button("r", " " .. " Recent files", ":Telescope oldfiles <CR>"),
            dashboard.button("n", "󰙴 " .. " New file", ":ene <BAR> startinsert <CR>"),
            dashboard.button("g", " " .. " Find text", ":Telescope live_grep <CR>"),
            dashboard.button("q", " " .. " Quit", ":qa<CR>"),
            --dashboard.button("s", " " .. " Restore Session", [[:lua require("persistence").load() <cr>]]),
            --dashboard.button("e", " " .. " Explore", ":Telescope file_browser<CR>"),
            --dashboard.button("l", "󰒲 " .. " Lazy", ":Lazy<CR>"),
        }
        dashboard.opts.layout[1].val = 5

        --dashboard.section.header.opts.hl = "AlphaHeader"
        --dashboard.section.buttons.opts.hl = "AlphaButtons"
        --dashboard.section.footer.opts.hl = "AlphaFooter"
        return dashboard
    end,
    config = function(_, dashboard)
        -- close Lazy and re-open when the dashboard is ready
        if vim.o.filetype == "lazy" then
            vim.cmd.close()
            vim.api.nvim_create_autocmd("User", {
                pattern = "AlphaReady",
                callback = function()
                    require("lazy").show()
                end,
            })
        end

        require("alpha").setup(dashboard.opts)

        vim.api.nvim_create_autocmd("User", {
            pattern = "LazyVimStarted",
            callback = function()
                local stats = require("lazy").stats()
                local ms = (math.floor(stats.startuptime * 100 + 0.5) / 100)
                local version = " "
                    .. vim.version().major
                    .. "."
                    .. vim.version().minor
                    .. "."
                    .. vim.version().patch
                local plugins = "             " .. stats.count .. "plugins        " .. ms .. "ms"
                local datetime = os.date(" %Y/%m/%d        %H:%M           Weekday: %a")
                local footer = version .. plugins .. '\n \n'..datetime  .. "\n"
                dashboard.section.footer.val = footer
                pcall(vim.cmd.AlphaRedraw)
            end,
        })
    end,
}
