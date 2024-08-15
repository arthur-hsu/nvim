local M = {
    'mg979/vim-visual-multi',
    event="VeryLazy",
    --enabled = false
    init = function()
        vim.g.VM_maps = {
            -- ["I BS"]      = '',
            ["Goto Next"] = "",
            ["Goto Prev"] = ""
        }
	end,
}

function M.config()
    local g = vim.g
    g.VM_skip_empty_lines = 1
    g.VM_quit_after_leaving_insert_mode = 1

    local hlslens = require('hlslens')
    if hlslens then
        local overrideLens = function(render, posList, nearest, idx, relIdx)
            local _ = relIdx
            local lnum, col = unpack(posList[idx])

            local text, chunks
            if nearest then
                text = ('[%d/%d]'):format(idx, #posList)
                chunks = {{' ', 'Ignore'}, {text, 'VM_Extend'}}
            else
                text = ('[%d]'):format(idx)
                chunks = {{' ', 'Ignore'}, {text, 'HlSearchLens'}}
            end
            render.setVirt(0, lnum - 1, col - 1, chunks, nearest)
        end
        local lensBak
        local config = require('hlslens.config')
        local gid = vim.api.nvim_create_augroup('VMlens', {})
        vim.api.nvim_create_autocmd('User', {
            pattern = {'visual_multi_start', 'visual_multi_exit'},
            group = gid,
            callback = function(ev)
                if ev.match == 'visual_multi_start' then
                    lensBak = config.override_lens
                    config.override_lens = overrideLens
                else
                    config.override_lens = lensBak
                end
                hlslens.start()
            end
        })
    end

end
return M
