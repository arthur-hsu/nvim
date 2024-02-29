return {
    {
        'https://github.com/junegunn/vim-easy-align',
        event = 'VeryLazy',
        config = function ()
            vim.cmd([[
            xmap ga <Plug>(EasyAlign)
            nmap ga <Plug>(EasyAlign)
            ]])
        end
    },
    {
        'godlygeek/tabular',
        event = 'VeryLazy',
    },
}
