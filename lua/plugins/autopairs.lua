local M = {
    "windwp/nvim-autopairs",
    event = 'VeryLazy',
    enabled = false,
}

function M.config()
    require('nvim-autopairs').setup({
        fast_wrap = {},
        enable_check_bracket_line = false,
        --map_bs = false,
        check_ts = true,
        ts_config = {
            lua = {'string'},-- it will not add a pair on that treesitter node
            javascript = {'template_string'},
            java = false,-- don't check treesitter on java
        }
    })
    ------------------------------------------------------
    -- use treesitter to check for a pair.
    local npairs = require("nvim-autopairs")
    local Rule = require('nvim-autopairs.rule')
    local ts_conds = require('nvim-autopairs.ts-conds')
    -- press % => %% only while inside a comment or string
    npairs.add_rules({
        Rule("%", "%", "lua")
        :with_pair(ts_conds.is_ts_node({'string','comment'})),
        Rule("$", "$", "lua")
        :with_pair(ts_conds.is_not_ts_node({'function'}))
    })
    local cmp = require("cmp")
    -- If you want insert `(` after select function or method item
    local cmp_autopairs = require('nvim-autopairs.completion.cmp')
    cmp.event:on('confirm_done',cmp_autopairs.on_confirm_done())
end
return M
