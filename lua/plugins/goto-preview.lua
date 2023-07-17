local M ={
    'rmagatti/goto-preview',
    event = 'VeryLazy',
}
function M.config()
    require('goto-preview').setup{
        default_mappings = true,
    }
    vim.keymap.set("n", "gr", "<cmd>lua require('goto-preview').goto_preview_references()<CR>", {noremap=true})
    vim.keymap.set("n", "gg", "<cmd>lua require('goto-preview').close_all_win()<CR>", {noremap=true})
end
return M
