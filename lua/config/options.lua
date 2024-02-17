---@diagnostic disable: undefined-global
local opt= vim.opt
local cmd= vim.cmd
local g= vim.g
opt.guifont= "JetBrainsMono Nerd Font Mono:h11"
opt.buftype= ""
opt.whichwrap= "b,s,<,>,[,],h,l"
opt.swapfile= false
vim.api.nvim_command('filetype plugin indent on')
opt.termguicolors= true
g.python_highlight_all= 1
opt.background= dark
opt.number= true
opt.relativenumber= true
vim.opt.clipboard= "unnamedplus"
opt.wrap= false
--opt.fileformat= unix
opt.textwidth= 200
opt.expandtab= true
opt.tabstop= 4
opt.shiftwidth= 4
opt.softtabstop= 4
opt.autoindent= true
opt.autochdir= true
opt.autoindent= true
-- opt.autowriteall = true
-- opt.autowrite = true
opt.cursorline= true
opt.cursorlineopt= 'number'
opt.fillchars = [[eob: ,fold: ,foldopen:,foldsep: ,foldclose:]]
opt.foldcolumn= "1"
opt.signcolumn= "yes"
-- opt.foldnestmax= "2"
opt.ruler = true
opt.showcmd= true
opt.showmatch= true
opt.scroll= 10
opt.scrolloff= 4
cmd("set backspace=indent,eol,start")
cmd("set mouse=a")
opt.matchtime= 1
opt.ignorecase= true
opt.incsearch= true
opt.hlsearch= true
opt.expandtab= true
opt.autoread= true
opt.modifiable= true
opt.laststatus= 0
--opt.iskeyword:append(":")

g.completeopt= "menu,menuone,noselect"
-- Decrease redraw time
vim.o.redrawtime= 100
opt.updatetime=100

vim.o.undofile= true
vim.opt.undodir= vim.fn.stdpath('state') .. '/undo'
vim.o.autoread = true
cmd('set isk-=.')
cmd ([[au BufReadPost * if line("'\"") > 0|if line("'\"") <= line("$")|exe("norm '\"")|else|exe "norm $"|endif|endif]])
vim.api.nvim_create_autocmd({ "BufEnter", "CursorHold", "CursorHoldI", "FocusGained" }, {
    command = "if mode() != 'c' | checktime | endif",
    pattern = { "*" },
})


