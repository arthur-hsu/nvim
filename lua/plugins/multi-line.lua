local M = {
    'mg979/vim-visual-multi',
    event="VeryLazy",
    --init = function()
        --vim.g.VM_maps = {
            --["I BS"] = ''
        --}
	--end,
    --enabled = false
}

function M.config()
    local g = vim.g
    --g.VM_maps = {
        --["I BS"] = ''
    --}
    g.VM_skip_empty_lines = 1
    g.VM_quit_after_leaving_insert_mode = 1
end
return M
