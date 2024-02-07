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




