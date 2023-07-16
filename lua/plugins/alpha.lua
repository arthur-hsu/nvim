local M = {
    'goolord/alpha-nvim',
    event = "VimEnter",
    dependencies = { 'nvim-tree/nvim-web-devicons' },
}


function M.config()
    require'alpha'.setup(require'alpha.themes.startify'.config)
end
return M