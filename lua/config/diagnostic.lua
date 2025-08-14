vim.diagnostic.config({
    virtual_text = false,
    signs = {
        severity = { min = vim.diagnostic.severity.WARN },
        text = {
            [vim.diagnostic.severity.ERROR] = " ",
            [vim.diagnostic.severity.WARN]  = " ",
            [vim.diagnostic.severity.INFO]  = " ",
            [vim.diagnostic.severity.HINT]  = "󰝶 ",
        },
        texthl = {
            [vim.diagnostic.severity.ERROR] = "DiagnosticSignError",
            [vim.diagnostic.severity.WARN]  = "DiagnosticSignWarn",
            [vim.diagnostic.severity.INFO]  = "DiagnosticSignInfo",
            [vim.diagnostic.severity.HINT]  = "DiagnosticSignHint",
        },
        linehl = {
            [vim.diagnostic.severity.ERROR] = "",
            [vim.diagnostic.severity.WARN]  = "",
            [vim.diagnostic.severity.INFO]  = "",
            [vim.diagnostic.severity.HINT]  = "",
        },
        numhl = {
            [vim.diagnostic.severity.ERROR] = "",
            [vim.diagnostic.severity.WARN]  = "",
            [vim.diagnostic.severity.INFO]  = "",
            [vim.diagnostic.severity.HINT]  = "",
        },
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
    -- virtual_text = {
    --     severity = { min = vim.diagnostic.severity.WARN }
    -- },
    --float = {
        --severity = { min = vim.diagnostic.severity.WARN },
        --show_header = true,
        --source = "always",  -- Or "if_many"
        --border = 'rounded',
        --focusable = false,
    --},
})
