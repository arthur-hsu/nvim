if vim.loop.os_uname().sysname == 'Windows_NT' then
    vim.g.python3_host_prog= "C:\\Users\\arthur\\.pyenv\\pyenv-win\\versions\\3.11.7\\python.exe"
elseif vim.loop.os_uname().sysname == 'Darwin' then
    vim.g.python3_host_prog= "/Users/arthur/.pyenv/versions/3.11.7/bin/python"
-- elseif vim.loop.os_uname().sysname == 'Linux' then
--     vim.g.python3_host_prog= "/home/arthur/.pyenv/versions/3.11.7/bin/python"
end

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
