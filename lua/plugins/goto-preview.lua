local M ={
    'rmagatti/goto-preview',
    enabled = false,
    event = 'VeryLazy',
}
function M.config()
    require('goto-preview').setup{
        width = 150; -- Width of the floating window
        height = 20; -- Height of the floating window
        default_mappings = false,
    }
    -- vim.keymap.set("n", "gr", "<cmd>lua require('goto-preview').goto_preview_references()<CR>", {noremap=true})
    -- vim.keymap.set("n", "q", "<cmd>lua require('goto-preview').close_all_win()<CR>", {noremap=true})
end
return M
