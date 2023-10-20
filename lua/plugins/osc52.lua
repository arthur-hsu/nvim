local M = {
    'ojroques/nvim-osc52',
    event="VeryLazy",
}

function M.config()
    require('osc52').setup {
        silent     = true,
    }

    local opts = {noremap = false, silent = true }
    if vim.fn.getenv('SSH_CLIENT')~=vim.NIL then
        vim.print(vim.fn.getenv('SSH_CLIENT'))
        local function copy(lines, _)
            require('osc52').copy(table.concat(lines, '\n'))
        end

        local function paste()
            return {vim.fn.split(vim.fn.getreg(''), '\n'), vim.fn.getregtype('')}
        end

        vim.g.clipboard = {
            name = 'osc52',
            copy = {['+'] = copy, ['*'] = copy},
            paste = {['+'] = paste, ['*'] = paste},
        }
        vim.keymap.set("v", "<leader>y", require('osc52').copy_visual)

    else
        --vim.keymap.set("v", "y", '"+y',opts)
        --if vim.loop.os_uname().sysname == 'Darwin' then
            --vim.keymap.set("v", "ç",require('osc52').copy_visual)
        --end
    end

    --Using nvim-osc52 as clipboard provider--

    --
    --automatically copy text that was yanked into register '+'
    
    --function copy()
        --if vim.v.event.operator == 'y' and vim.v.event.regname == '+' then
            --require('osc52').copy_register('+')
        --end
    --end
    --vim.api.nvim_create_autocmd('TextYankPost', {callback = copy})

    --function C_c()
        --if vim.v.event.operator == '<C-c>' and vim.v.event.regname == '+' then
            --require('osc52').copy_register('+')
        --end
    --end
    --vim.api.nvim_create_autocmd('TextYankPost', {callback = C_c})
end
return M
