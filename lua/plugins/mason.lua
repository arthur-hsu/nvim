return{
    {

        "https://github.com/williamboman/mason.nvim",
        cmd = "Mason",
        opts = {
            max_concurrent_installers = 4,
            ui = { border = "rounded" },
            ensure_installed = {

                -- Formatter
                --"pylint",
                --"flake8",
                "stylua",
                "prettier",
                "shfmt",
                "jq",
                "codelldb",
                -- Linter
                "eslint_d",
                -- "standardrb",
                "golangci-lint",
                "shellcheck",
                "markdownlint",
                "yamllint",
            },
        },
        -- ---@param opts MasonSettings | {ensure_installed: string[]}
        config = function(_, opts)
            require("mason").setup(opts)
            local mr = require("mason-registry")
            local function ensure_installed()
                for _, tool in ipairs(opts.ensure_installed) do
                    local p = mr.get_package(tool)
                    if not p:is_installed() then
                        p:install()
                    end
                end
            end
            if mr.refresh then
                mr.refresh(ensure_installed)
            else
                ensure_installed()
            end
        end,
    },
}
