return{
    {

        "williamboman/mason.nvim",
        cmd = "Mason",
        opts = {
            max_concurrent_installers = 4,
            ui = { border = "rounded" },
        },
        -- ---@param opts MasonSettings | {ensure_installed: string[]}
        config = function(_, opts)
            require("mason").setup(opts)
        end,
    },
}
