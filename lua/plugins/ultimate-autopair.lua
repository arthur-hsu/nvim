return {
    'altermo/ultimate-autopair.nvim',
    event={'InsertEnter','CmdlineEnter'},
    branch='development',
    --enabled = false,
    config = function ()
        require('ultimate-autopair').setup({
        --Config goes here
        })
        local cmp=require('cmp')
        local Kind=cmp.lsp.CompletionItemKind
        cmp.event:on(
            'confirm_done',
            function (evt)
                if vim.tbl_contains({Kind.Function,Kind.Method},evt.entry:get_completion_item().kind) then
                    vim.api.nvim_feedkeys('()'..vim.api.nvim_replace_termcodes('<Left>',true,true,true),'n',false)
                end
            end
        )
    end
}
