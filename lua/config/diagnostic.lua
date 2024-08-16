
local sign = function(opts)
    vim.fn.sign_define(opts.name, {
        texthl = opts.name,
        text   = opts.text,
        numhl  = ''
    })
end

sign({name = 'DiagnosticSignError',text = ' '})
sign({name = 'DiagnosticSignWarn', text = ' '})
sign({name = 'DiagnosticSignInfo', text = ' '})
sign({name = 'DiagnosticSignHint', text = '󰝶 '})

vim.diagnostic.config({
    virtual_text = false,
    -- virtual_text = {
    --     severity = { min = vim.diagnostic.severity.WARN }
    -- },
    signs = {
        severity = { min = vim.diagnostic.severity.WARN }
    },
    -- underline = {severity = {min = vim.diagnostic.severity.WARN}},
    update_in_insert = false,
    severity_sort = true,
    float = {
        border = 'rounded',
        show_header = true,
        source = "always",  -- Or "if_many"
        focusable = false,
    }
    --float = {
        --severity = { min = vim.diagnostic.severity.WARN },
        --show_header = true,
        --source = "always",  -- Or "if_many"
        --border = 'rounded',
        --focusable = false,
    --},
})
