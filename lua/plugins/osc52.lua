local M = {
  'ojroques/nvim-osc52',
  event="VeryLazy",
}

function M.config()
    require('osc52').setup {
        silent     = true,
    }

    vim.keymap.set('v', '<leader>y', require('osc52').copy_visual)
    --Using nvim-osc52 as clipboard provider
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
    local opts = {noremap = false, silent = true }
	if vim.g.clipboard.name == 'osc52' then
	    vim.keymap.set("v", "<C-c>", require('osc52').copy_visual,opts)
	    vim.keymap.set("v", "y", require('osc52').copy_visual,opts)
	    if vim.loop.os_uname().sysname == 'Darwin' then
            vim.keymap.set("v", "M-c",require('osc52').copy_visual,opts)
	    end
	else
	    vim.keymap.set("v", "<C-c>", '"+y', opts)
	    vim.keymap.set("v", "y", '"+y', opts)
	    if vim.loop.os_uname().sysname == 'Darwin' then
            vim.keymap.set("v", "<M-c>", '"+y', opts)
	    end
	end
end
return M
