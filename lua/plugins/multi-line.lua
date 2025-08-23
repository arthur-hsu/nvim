return {
    'mg979/vim-visual-multi',
    event="VeryLazy",
    -- enabled = false,
    keys = {
        { "<C-LeftMouse>"    , mode = { "n" }, "<Plug>(VM-Mouse-Cursor)", desc = "add cursor at clicked position" },
        { "<C-RightMouse>"   , mode = { "n" }, "<Plug>(VM-Mouse-Word)", desc = "select clicked word" },
        { "<M-C-RightMouse>" , mode = { "n" }, "<Plug>(VM-Mouse-Column)", desc = "create column of cursors" },
    },
    init = function()
        vim.g.VM_maps = {
            -- ["I BS"]      = "",
            ["Goto Next"] = "]v",
            ["Goto Prev"] = "[v"
        }
	end,
    config = function ()
        local g = vim.g
        g.VM_skip_empty_lines               = 1
        g.vm_set_statusline                 = 0
        g.vm_silent_exit                    = 1
        g.vm_quit_after_leaving_insert_mode = 1
        g.vm_mouse_mappings                 = 1
    end
}
