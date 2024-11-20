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
        if os_name == "Darwin" then
            table.insert(tbl, { import = "macos" })
        end
        return tbl
end
local spec_list = gen_spec_list()

require("lazy").setup({
    spec = spec_list,
    concurrency = 24,
    defaults = { lazy = true, version = nil },
    install = {
        -- colorscheme = {"material"},

        colorscheme = {"zephyr"},
        -- colorscheme = {"tokyonight"},
        -- colorscheme = {"nordic"},
        -- colorscheme = {"kanagawa"},
        missing = true
    },
    checker = { enabled = true, notify = false },
    change_detection = {
        -- automatically check for config file changes and reload the ui
        enabled = true,
        notify  = false, -- get a notification when changes are found
    },
    ui = { border = "rounded" },
})

local enter_load = function()
   require("lazy").load({
       plugins={
           "nvim-treesitter",
           "gitsigns.nvim",
           "bufferline.nvim",
           "statuscol.nvim",
           "snacks.nvim",
           "nvim-lspconfig",
           "lspsaga.nvim",
           "lualine.nvim",
           "indent-blankline.nvim",
           "copilot.lua",
       }
   })
   vim.cmd[[LspStart]]
end
vim.api.nvim_create_autocmd("UIEnter", {callback= enter_load})
-- vim.api.nvim_create_autocmd("UIEnter", {pattern="*.md", callback=function() require"lazy.loader".load({plugins={"pastify.nvim"}}) end })
