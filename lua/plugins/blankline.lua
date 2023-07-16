local M = {
    "lukas-reineke/indent-blankline.nvim",
    event = 'VeryLazy',
    enabled = true,
}


function M.config()
    vim.cmd [[highlight IndentBlanklineIndent1 guifg=#98C379 gui=nocombine]]
    vim.cmd [[highlight IndentBlanklineIndent2 guifg=#E5C07B gui=nocombine]]
    vim.cmd [[highlight IndentBlanklineIndent3 guifg=#56B6C2 gui=nocombine]]
    vim.cmd [[highlight IndentBlanklineIndent4 guifg=#61AFEF gui=nocombine]]
    vim.cmd [[highlight IndentBlanklineIndent5 guifg=#C678DD gui=nocombine]]
    vim.cmd [[highlight IndentBlanklineIndent6 guifg=#E06C75 gui=nocombine]]
    vim.opt.list = true
    require("indent_blankline").setup {
        space_char_blankline = " ",
        show_current_context = true,
        char_highlight_list = {
            "IndentBlanklineIndent1",
            "IndentBlanklineIndent2",
            "IndentBlanklineIndent3",
            "IndentBlanklineIndent4",
            "IndentBlanklineIndent5",
            "IndentBlanklineIndent6",
        },
    }
end
return M