return {
    {
        'norcalli/nvim-colorizer.lua',
        event = { "BufReadPost", "BufNewFile" },
        config = function ()
            require("colorizer").attach_to_buffer(0, {names = false, mode = "background", css = true})
        end
    },
    { 'nvim-tree/nvim-web-devicons', lazy = true, },
    { "nathom/filetype.nvim", event = "VimEnter", },
    { 'lithammer/nvim-pylance', lazy=true, enabled = false, },
    { 'dstein64/vim-startuptime', event="VimEnter", enabled = false, },
    {
        "keaising/im-select.nvim",
        config = function()
            require("im_select").setup()
        end,
    },
    {
        'petertriho/nvim-scrollbar',
        event = "VeryLazy",
        dependencies = {
            "kevinhwang91/nvim-hlslens",
            config = function()
                require("hlslens").setup({
                    override_lens = function(render, posList, nearest, idx, relIdx)
                        local sfw = vim.v.searchforward == 1
                        local indicator, text, chunks
                        local absRelIdx = math.abs(relIdx)
                        if absRelIdx > 1 then
                            indicator = ('%d%s'):format(absRelIdx, sfw ~= (relIdx > 1) and '▲' or '▼')
                        elseif absRelIdx == 1 then
                            indicator = sfw ~= (relIdx == 1) and '▲' or '▼'
                        else
                            indicator = ''
                        end

                        local lnum, col = unpack(posList[idx])
                        if nearest then
                            local cnt = #posList
                            if indicator ~= '' then
                                text = ('[%s %d/%d]'):format(indicator, idx, cnt)
                            else
                                text = ('[%d/%d]'):format(idx, cnt)
                            end
                            chunks = {{' '}, {text, 'HlSearchLensNear'}}
                        else
                            text = ('[%s %d]'):format(indicator, idx)
                            chunks = {{' '}, {text, 'HlSearchLens'}}
                        end
                        render.setVirt(0, lnum - 1, col - 1, chunks, nearest)
                    end,
                    build_position_cb = function(plist, _, _, _)
                        require("scrollbar.handlers.search").handler.show(plist.start_pos)
                    end,
                })

                -- vim.cmd([[
                -- augroup scrollbar_search_hide
                -- autocmd!
                -- autocmd CmdlineLeave : lua require('scrollbar.handlers.search').handler.hide()
                -- augroup END
                -- ]])
            end,
        },
        config = function()
            require("scrollbar").setup({
                marks = {
                    Search = {
                        text      = { "-" },
                        priority  = 1,
                        gui       = nil,
                        color     = "#31a8ff",
                        cterm     = nil,
                        color_nr  = nil, -- cterm
                        highlight = "Search",
                    },
                },
                excluded_buftypes = {
                    "terminal",
                    "nofile"
                },
                excluded_filetypes = {
                    "DiffviewFiles",
                    "DiffviewFileHistory",
                    "TelescopePrompt",
                    "cmp_docs",
                    "cmp_menu",
                    "noice",
                    "prompt",
                },
                handlers = {
                    cursor     = true,
                    diagnostic = false,
                    gitsigns   = true, -- Requires gitsigns
                    handle     = true,
                    search     = true, -- Requires hlslens
                    ale        = false, -- Requires ALE
                },
            })
            require("scrollbar.handlers.gitsigns").setup()
            require("scrollbar.handlers.search").setup()
        end,
    }
}
