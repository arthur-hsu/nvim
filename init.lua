if vim.loop.os_uname().sysname == 'Windows_NT' then
    vim.g.python3_host_prog= "C:\\Users\\arthur\\.pyenv\\pyenv-win\\versions\\3.11.7\\python.exe"
elseif vim.loop.os_uname().sysname == 'Darwin' then
    vim.g.python3_host_prog= "/Users/arthur/.pyenv/versions/3.11.7/bin/python"
-- elseif vim.loop.os_uname().sysname == 'Linux' then
--     vim.g.python3_host_prog= "/home/arthur/.pyenv/versions/3.11.7/bin/python"
end

local ver = vim.version()  -- Correctly fetch version information
-- You need to use `ver.minor` instead of `vim.minor` since the version info is stored in `ver`
if ver.minor > 10 then
    if vim.g.vscode then
        -- VSCode extension
        require "config.options"
    else
        -- ordinary Neovim
        require "config.diagnostic"
        require "config.lazy"
        require "config.keymaps"
        require "config.options"
        vim.cmd("TransparentEnable")
    end
else
    require "config.options"
    local opt    = vim.opt
    local cmd    = vim.cmd
    local g      = vim.g
    local keymap = vim.api.nvim_set_keymap
    local opts = { noremap = true, silent = true }
    opt.foldcolumn = "0"
    opt.signcolumn = "no"
    keymap("n", "<leader>nh", "<cmd>let @/ = ''<CR><cmd>noh<CR>", opts)
    keymap("n", "<TAB>",   ">>",  opts)
    keymap("n", "<S-TAB>", "<<",  opts)
    keymap("v", "<TAB>",   ">gv", opts)
    keymap("v", ">",       ">gv", opts)
    keymap("v", "<S-TAB>", "<gv", opts)
    keymap("v", "<",       "<gv", opts)
    keymap("v", "<M-c>", "y", opts)
    keymap("n", "<C-s>", ":w<CR>", opts)
    keymap("n", "<C-z>", "<C-o><C-o>", opts)
    keymap("i", "<C-s>", "<esc>:w<CR>", opts)
    keymap("i", "<C-z>", "<esc><C-o><C-o>", opts)
    cmd('filetype plugin indent on')
    cmd('colorscheme habamax')
end
