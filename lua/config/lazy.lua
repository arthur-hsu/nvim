--- Install lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable",
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)
-- Configure lazy.nvim

local gen_spec_list = function ()
        local tbl = {}
        local os_name = vim.loop.os_uname().sysname
        table.insert(tbl, { import = "plugins" })
        if os_name == "Darwin" or os_name == "Windows_NT" then
            table.insert(tbl, { import = "macos" })
        end
        return tbl
end
local spec_list = gen_spec_list()

require("lazy").setup({
    spec = spec_list,
    -- spec = {},
    defaults = { lazy = true, version = nil },
    install = {
        missing = true,
        colorscheme = { "vim" },
        -- colorscheme = { "zephyr" },
    },
    checker = {
        -- automatically check for plugin updates
        enabled = true,
        concurrency = nil, ---@type number? set to 1 to check for updates very slowly
        notify = false,    -- get a notification when new updates are found
        frequency = 86400, -- check for updates every hour
        check_pinned = false, -- check for pinned packages that can't be updated
    },
    change_detection = {
        -- automatically check for config file changes and reload the ui
        enabled = true,
        notify  = true, -- get a notification when changes are found
    },
    ui = { border = "rounded" },
})

local enter_load = function()
    require("lazy").load({
        plugins = {
            "nvim-treesitter",
            "bufferline.nvim",
            "lualine.nvim",
            "gitsigns.nvim",
            -- "snacks.nvim",
            "nvim-lspconfig",
            "lspsaga.nvim",
            "copilot.lua",
        }
    })
    vim.cmd [[LspStart]]
end
vim.api.nvim_create_autocmd("UIEnter", {callback= enter_load})
