---@diagnostic disable: undefined-global
local opt = vim.opt
local cmd = vim.cmd
local g   = vim.g

-- Restore cursor position
vim.api.nvim_create_autocmd({ "BufReadPost" }, {
    pattern = { "*" },
    callback = function()
        vim.api.nvim_exec('silent! normal! g`"zv', false)
    end,
})

-- 设置退格键的行为
opt.backspace          = {'indent', 'eol', 'start'}

-- 启用鼠标支持
opt.mouse              = 'a'

-- 设置 GUI 字体
opt.guifont            = "JetBrainsMono Nerd Font Mono:h11"

-- 设置缓冲区的类型，默认为空
opt.buftype            = ""

-- 设置在哪些情况下可以跨越行界进行移动
opt.whichwrap          = "b,s,<,>,[,],h,l"

-- 禁用交换文件
opt.swapfile           = false

-- 禁用寫入備份文件
opt.writebackup        = false

-- 启用真彩色支持
opt.termguicolors      = true

-- 全局变量，为 Python 代码高亮启用全部功能
g.python_highlight_all = 1

-- 设置背景类型为暗色
opt.background         = "dark"

-- 启用行号显示
opt.number             = true

-- 启用相对行号显示
opt.relativenumber     = true

-- 设置剪切板模式
opt.clipboard          = "unnamedplus"

-- 禁用自动换行
opt.wrap               = false

-- 设置文本宽度限制
opt.textwidth          = 200

-- 将制表符转换为相应的空格数
opt.expandtab          = true

-- 设置制表符占用的空格数
opt.tabstop            = 4

-- 设置自动缩进的空格数
opt.shiftwidth         = 4

-- 设置软制表符的空格数
opt.softtabstop        = 4

-- 启用自动缩进
opt.autoindent         = true

-- 启用自动切换当前目录为当前文件的目录
opt.autochdir          = true

-- 启用光标所在行高亮
opt.cursorline         = true

-- 设置光标所在行高亮的选项为行号
opt.cursorlineopt      = 'number'

-- 设置填充字符，如折叠边界的视觉表示
opt.fillchars          = [[eob: ,fold: ,foldopen:,foldsep: ,foldclose:]]

-- 设置折叠栏的宽度为1
opt.foldcolumn         = "1"

-- 始终显示签名列
opt.signcolumn         = "yes"

-- 显示光标位置的状态栏信息
opt.ruler              = true

-- 显示命令输入的部分命令
opt.showcmd            = true

-- 输入括号时显示匹配的括号
opt.showmatch          = true

-- 设置滚动时的行数
opt.scroll             = 10

-- 设置屏幕上下方至少保留的行数
opt.scrolloff          = 4

-- 设置显示匹配项的时间(十分之一秒)
opt.matchtime          = 1

-- 搜索时忽略大小写
opt.ignorecase         = true

-- 输入搜索词时即时显示搜索结果
opt.incsearch          = true

-- 高亮显示搜索结果
opt.hlsearch           = true

-- 将Tab转换为空格
opt.expandtab          = true

-- 自动读取上次编辑时外部程序修改过的文件
opt.autoread           = true

-- 允许修改缓冲区内容
opt.modifiable         = true

-- 不显示状态栏（设置为0时）
opt.laststatus         = 0

-- 启用撤销文件功能
opt.undofile           = true

-- 设置撤销文件的保存目录
opt.undodir            = vim.fn.stdpath('cache') .. '/undo'

-- 自动重新加载外部修改的文件
opt.autoread           = true

-- 设置补全菜单的行为
g.completeopt          = "menu,menuone,noselect"

-- 设置弹出菜单的最大高度
opt.pumheight          = 10

-- 减少重绘时间
opt.redrawtime         = 100

-- 设置更新时间，影响诸如光标闪烁的特性
opt.updatetime         = 100

-- 在切换文件前自动保存
opt.autowrite          = true

-- 从'iskeyword'选项中移除'.'
opt.iskeyword:remove('.')

-- 允許markdown文件中的標示符號轉譯
opt.conceallevel       = 3

-- 在normal和visual模式下隱藏標示符號
opt.concealcursor      = 'n'

-- 設置guicursor
opt.guicursor:append("n-v-c:blinkon500-blinkoff500")
opt.guicursor:append("i-ci:ver40-iCursor-blinkon500-blinkoff500")
opt.guicursor:append("r-cr-o:hor20-blinkon500-blinkoff500")
-- vim.api.nvim_create_autocmd({ 'InsertEnter' }, {
--   callback = function () vim.lsp.inlay_hint(true) end,
-- })
-- vim.api.nvim_create_autocmd({ 'InsertLeave' }, {
--   callback = function () vim.lsp.inlay_hint(false) end,
-- })

-- 设置文件格式为unix
-- opt.fileformat         = "unix"

-- 写入文件时自动保存所有缓冲区
-- opt.autowriteall       = true

-- 设置最大折叠嵌套级别为2
-- opt.foldnestmax        = "2"

-- 向'iskeyword'选项中添加':'
-- opt.iskeyword:append(":")
