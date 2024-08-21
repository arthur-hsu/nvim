return {
    {
        "keaising/im-select.nvim",
        event = "VeryLazy",
        config = function()
            require("im_select").setup({
                set_previous_events = {},
            })
        end,
    },
}
