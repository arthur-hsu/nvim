local M = {
    'glepnir/dashboard-nvim',
    enabled = false,
    lazy=false,
    event = 'VimEnter',
    dependencies = { {'nvim-tree/nvim-web-devicons'}},

}
function M.config()
    require('dashboard').setup({
        theme = 'doom',
        config = {
            header = {}, --your header
            center = {
                {
                    icon = ' ',
                    icon_hl = 'Title',
                    desc = 'Find File           ',
                    desc_hl = 'String',
                    key = 'b',
                    keymap = 'SPC f f',
                    key_hl = 'Number',
                    action = 'lua print(2)'
                },
                {
                    icon = ' ',
                    desc = 'Find Dotfiles',
                    key = 'f',
                    keymap = 'SPC f d',
                    action = 'lua print(3)'
                },
            },
            footer = {}  --your footer
        }
    })
end
return M
