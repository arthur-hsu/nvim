return {
    {
        'chipsenkbeil/distant.nvim',
        branch = 'v0.3',
        event = "VeryLazy",
        dependencies = {
            'nvim-telescope/telescope.nvim',
        },
        config = function()
            require('distant'):setup({
                keymap = {
                    ui = {
                        main = {
                            connections = {
                                -- kill = '<C-K>',
                                -- toggle_info = '<C-I>'
                            }
                        }
                    }
                }
            })
            require('telescope').load_extension('distant')
            local wk = require("which-key")

            wk.add(
            {
                { "<leader>f", group = "find" },
                { "<leader>fd", "<cmd>Telescope distant search<cr>", desc = "Open distant search" },
            }
            )


            -- NOTE: This is a workaround for install distant client
            -- For server install use: 
            --      ssh user@domain 'curl -L https://sh.distant.dev | sh -s -- --on-conflict overwrite'
            local notify = require("notify")
            local installation = function ()
                local distant_dir = vim.fn.stdpath("data") .. "/distant.nvim"
                local install_cmd = 'sh -c "curl -L https://sh.distant.dev | sh -s -- --on-conflict overwrite --install-dir ' .. distant_dir .. '/bin"'

                local handle
                handle = vim.loop.spawn("sh", {
                    args = { "-c", install_cmd },
                    stdio = { nil, nil, nil },
                }, function(code, signal)
                    handle:close()
                    if code == 0 then
                        notify("Distant client install success！", "info", { title = "Distant installer" })
                    else
                        notify("Distant client install fail, return code: " .. code .. " signal: " .. signal, "error",
                        { title = "Distant installer" })
                    end
                end)

            end
            local distant_dir = vim.fn.stdpath("data") .. "/distant.nvim"
            if not vim.loop.fs_stat(distant_dir) then
                notify("Install Distant client...", "info", { title = "Distant installer" })
                installation()
            end
        end
    }
}
