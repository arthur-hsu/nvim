local M = {
    'nvimdev/lspsaga.nvim',
    lazy = true,
    --enevt = "InsertEnter",
    event = { "BufReadPost", "BufNewFile" },
    dependencies = {
        'nvim-treesitter/nvim-treesitter', -- optional
        'nvim-tree/nvim-web-devicons'     -- optional
    }
}


function M.config()
    require('lspsaga').setup({})
end

return M
