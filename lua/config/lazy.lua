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
require("lazy").setup({
    spec = {
        { import = "plugins" },
    },
    concurrency = 24,
    defaults = { lazy = true, version = nil },
    install = {
        colorscheme = {"zephyr"},
        -- colorscheme = {"tokyonight"},
        --colorscheme = {"nordic"},
        -- colorscheme = {"kanagawa"},
        missing = true
    },
    checker = { enabled = true, notify = false },
    change_detection = {
        -- automatically check for config file changes and reload the ui
        enabled = true,
        notify = false, -- get a notification when changes are found
    },
    --ui = { border = "rounded" },
})
