local M = {
    'mg979/vim-visual-multi',
    event="VeryLazy",
}

function M.config()
    local g = vim.g 
    -- g.VM_theme = ''
    g.VM_skip_empty_lines = 1
    g.VM_quit_after_leaving_insert_mode = 1
    -- g.VM_Mono_hl   = 'DiffText'
    -- g.VM_Extend_hl = 'DiffAdd'
    -- g.VM_Cursor_hl = 'Visual'
    -- g.VM_Insert_hl = 'DiffChange'
end
return M