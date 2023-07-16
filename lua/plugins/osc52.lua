local M = {
  'ojroques/nvim-osc52',
  event="VeryLazy",
}

function M.config()
    require('osc52').setup {}
    vim.keymap.set('v', '<C-c>', require('osc52').copy_visual)


    --Using nvim-osc52 as clipboard provider

    --if vim.loop.os_uname().sysname == 'Linux' then
        --vim.keymap.set('v', '<leader>c', '"+y')
        --local function copy(lines, _)
          --require('osc52').copy(table.concat(lines, '\n'))
        --end

        --local function paste()
          --return {vim.fn.split(vim.fn.getreg(''), '\n'), vim.fn.getregtype('')}
        --end

        --vim.g.clipboard = {
          --name = 'osc52',
          --copy = {['+'] = copy, ['*'] = copy},
          --paste = {['+'] = paste, ['*'] = paste},
        --}
    --end
end
return M
