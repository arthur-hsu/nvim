return {
    'numToStr/Comment.nvim',
    event = "VeryLazy",
    opts = {
        -- `gco` - Insert comment to the next line and enters INSERT mode
        -- `gcO` - Insert comment to the previous line and enters INSERT mode
        -- `gcA` - Insert comment to end of the current line and enters INSERT mode
        toggler = {
            line = '<leader>c<space>',  --Line-comment toggle keymap
            block = 'gbc',              --Block-comment toggle keymap
        },
        opleader = {
            line = '<leader>c<space>',  --Line-comment keymap
            block = 'gb',               --Block-comment keymap
        }
    },
}
