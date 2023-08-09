
return{
    {
        'goolord/alpha-nvim',
        --enabled = false,
        lazy=false,
        ement = "VimEnter",
        dependencies = { 'nvim-tree/nvim-web-devicons' },
        config = function ()
            --require'alpha'.setup(require'alpha.themes.startify'.config)
            require'alpha'.setup(require'alpha.themes.dashboard'.config)
        end
    }
}
