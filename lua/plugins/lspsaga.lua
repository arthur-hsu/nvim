local M = {
    'nvimdev/lspsaga.nvim',
    lazy = false,
    enevt = "VeryLazy",
    dependencies = {
        'nvim-treesitter/nvim-treesitter', -- optional
        'nvim-tree/nvim-web-devicons'     -- optional
    }
}


function M.config()
    require('lspsaga').setup({})
end

return M
