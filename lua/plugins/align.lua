return {
    {
        'junegunn/vim-easy-align',
        event = 'VeryLazy',
        config = function ()
            -- Delimiter key (a single keystroke; <Space>, =, :, ., |, &, #, ,) or an arbitrary regular expression followed by <CTRL-X>
            vim.cmd([[
            xmap ga <Plug>(EasyAlign)
            nmap ga <Plug>(EasyAlign)
            ]])
        end
    },
    {
        'godlygeek/tabular',
        enabled = false,
        event = 'VeryLazy',
    },
}
