if vim.loop.os_uname().sysname == 'Windows_NT' then
    vim.opt.shell = "pwsh"
end
-- elseif vim.loop.os_uname().sysname == 'Darwin' then
--     vim.g.python3_host_prog= "/Users/arthur/.pyenv/versions/3.11.7/bin/python"
-- -- elseif vim.loop.os_uname().sysname == 'Linux' then
-- --     vim.g.python3_host_prog= "/home/arthur/.pyenv/versions/3.11.7/bin/python"
-- end


local ver = vim.version() -- You need to use ver.major.. '.' .. ver.minor .. '.' .. ver.patch

if ver.minor >= 9 then
    if vim.g.vscode then
        -- VSCode extension
        require "config.options"
    else
        -- ordinary Neovim
        require "config.lazy"
        require "config.options"
        vim.opt.cmdheight = 0
        require "config.keymaps"
        require "config.autocmd"
        require "config.diagnostic"
    end
else
    require "config.options"
    local opt       = vim.opt
    local cmd       = vim.cmd
    local g         = vim.g
    local keymap    = vim.api.nvim_set_keymap
    local opts      = { noremap = true, silent = true }
    opt.foldcolumn  = "0"
    opt.signcolumn  = "no"
    opt.laststatus  = 0
    opt.writebackup = false
    opt.swapfile    = false
    keymap("n", "<leader>nh", "<cmd>let @/ = ''<CR><cmd>noh<CR>", opts)
    keymap("n", "<TAB>",      ">>",                               opts)
    keymap("n", "<S-TAB>",    "<<",                               opts)
    keymap("v", "<TAB>",      ">gv",                              opts)
    keymap("v", ">",          ">gv",                              opts)
    keymap("v", "<S-TAB>",    "<gv",                              opts)
    keymap("v", "<",          "<gv",                              opts)
    keymap("v", "<M-c>",      "y",                                opts)
    keymap("n", "<C-s>",      ":w<CR>",                           opts)
    keymap("n", "<C-z>",      "<C-o><C-o>",                       opts)
    keymap("i", "<C-s>",      "<esc>:w<CR>",                      opts)
    keymap("i", "<C-z>",      "<esc><C-o><C-o>",                  opts)
    cmd('filetype plugin indent on')
    -- cmd('set nu! rnu!')
    -- cmd('colorscheme habamax')
end
