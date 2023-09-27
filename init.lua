if vim.g.vscode then
    -- VSCode extension
    require "config.options"
else
    -- ordinary Neovim
    require "config.diagnostic"
    require "config.lazy"
    require "config.keymaps"
    require "config.lualine_theme"
    require "config.options"
    --vim.cmd.colorscheme "kanagawa"
    --vim.cmd.colorscheme "darkplus"
    vim.cmd.colorscheme "zephyr"
    require "config.color"
    --vim.cmd.colorscheme "tokyonight"
end




