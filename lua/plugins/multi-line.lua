return {
    'mg979/vim-visual-multi',
    event="VeryLazy",
    -- enabled = false,
    init = function()
        vim.g.VM_maps = {
            -- ["I BS"]      = "",
            ["Goto Next"] = "",
            ["Goto Prev"] = ""
        }
	end,
    config = function ()
        local g = vim.g
        g.VM_skip_empty_lines               = 1
        g.VM_set_statusline                 = 0
        g.VM_silent_exit                    = 1
        g.VM_quit_after_leaving_insert_mode = 1
    end
}
