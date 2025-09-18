return {
    {
        'mrcjkb/rustaceanvim',
        ft = { 'rust' },
        config = function ()
            vim.g.rustaceanvim = {
                tools = {
                    hover_actions = {
                        auto_focus = true,
                    },
                },
            }
        end
    }
}
