-- Modes
-- normal_mode       = "n",
-- insert_mode       = "i",
-- visual_mode       = "v",
-- visual_block_mode = "x",
-- term_mode         = "t",
-- command_mode      = "c",

-- Shorten function name
local keymap    = vim.keymap.set



local function _git_root()
    local git_root = vim.fs.find(".git", { upward = true, type = "directory" })[1]
    if git_root then
        git_root = vim.fs.dirname(git_root)
        return git_root
    else
        return vim.fn.getcwd()
    end
end



-- Custom Commands
vim.api.nvim_create_user_command("DiffviewFileHistoryToggle", function(e)
    local view = require("diffview.lib").get_current_view()

    if view then
        vim.cmd("DiffviewClose")
    else
        vim.cmd("DiffviewFileHistory " .. e.args)
    end
end, { nargs = "*" })

vim.api.nvim_create_user_command("DiffviewToggle", function(e)
    local view = require("diffview.lib").get_current_view()

    if view then
        vim.cmd("DiffviewClose")
    else
        vim.cmd("DiffviewOpen " .. e.args)
    end
end, { nargs = "*" })
vim.api.nvim_create_user_command("CleanShada", function()
    local shada_dir = vim.fn.stdpath("data") .. "/shada"
    for _, file in ipairs(vim.fn.glob(shada_dir .. "/*", true, true)) do
        os.remove(file)
    end
    print("All shada files deleted in: " .. shada_dir)
    vim.cmd("wshada")
    vim.cmd("rshada!")
end, {})

vim.api.nvim_create_user_command('Msg', function () Snacks.notifier.show_history() end, {})

vim.api.nvim_create_user_command("Code", function(opts)
	local arg = opts.args -- 取得命令的參數字串
    local cmd_opt = { silent = true }
	if arg == nil or arg == "" then
		-- 沒有輸入參數：開啟當前 Git 根目錄
		-- 假設 _git_root() 函式已經定義並返回 Git 根目錄路徑
		-- 請確保 _git_root() 函式在你的配置中可用
		local git_root = _git_root()
		if git_root then
			local cmd = string.format('!code -n "%s"', git_root)
			vim.cmd(cmd, cmd_opt)
		else
			print("Error: Git root not found. Cannot open VS Code.")
		end
	elseif arg == "." then
		-- 參數是 "."：開啟當前緩衝區的當前行和列
		local filepath = vim.api.nvim_buf_get_name(0) -- 完整檔案路徑
		if filepath == "" then -- 檢查是否是未保存的緩衝區
			print("Cannot open current line in VS Code: Buffer not saved to a file.")
			return
		end
		local cursor = vim.api.nvim_win_get_cursor(0) -- {行號, 列號}
		local line = cursor[1]
		local col = cursor[2] + 1 -- Lua 的 col 是從 0 開始，VS Code 通常從 1 開始

		-- 使用 --goto 參數讓 VS Code 跳轉到指定位置
		local cmd = string.format('!code --goto "%s:%d:%d"', filepath, line, col)
		vim.cmd(cmd, cmd_opt)
	else
		-- 其他參數：作為路徑直接打開
		local cmd = string.format('!code "%s"', arg)
		vim.cmd(cmd, cmd_opt)
	end
end, {
	nargs = "?", -- 接受零個或一個參數
	desc = "Open current project/file/line in VS Code",
	-- 你原先的 completion = 'dir' 可能會與 '.' 參數的邏輯衝突，
	-- 因為 '.' 本身是個有效的目錄名。
	-- 如果你希望為其他路徑參數提供目錄補全，可以保留。
	complete = 'dir'
})

vim.api.nvim_create_user_command('Dashboard', function () Snacks.dashboard.open() end, {})
---------------------------------------------------------------------




local opts = { silent = true }
local term_opts = { silent = true }
if vim.loop.os_uname().sysname == 'Linux' or vim.loop.os_uname().sysname == 'Darwin' then
    keymap("n", "<leader>rc", ":Telescope file_browser path=$HOME/.config/nvim/lua<cr>", opts)
elseif vim.loop.os_uname().sysname == 'Windows_NT' then
    keymap("n", "<leader>rc", ":Telescope file_browser path=$HOME\\AppData\\Local\\nvim\\lua<CR>", opts)
end

-- Disable cmd history keymap
vim.api.nvim_set_keymap("n", "q:", "<Nop>", opts)


keymap("n", "x", "\"_x", opts)
keymap("n", "X", "\"_X", opts)
keymap("v", "x", "\"_x", opts)


keymap("n", "<leader>L",  "<cmd>Lazy<CR>",                                                    opts )
keymap("n", "<leader>mc", "<cmd>Mason<CR>",                                                   opts )
keymap("n", "<leader>nh", "<cmd>let @/ = ''<CR><cmd>noh<CR>",                                 opts )
keymap("n", "<F2>",       "<cmd>Telescope file_browser path=%:p:help select_buffer=true<cr>", opts )
keymap("n", "<F3>",       "<cmd>Telescope<cr>",                                               opts )
keymap('n', '<F4>',       '<cmd>TodoFzfLua<CR>',                                              opts )
keymap("n", "<F5>",       "<cmd>RunCode<CR>",                                                 opts )
keymap("n", "<F6>",       "<cmd>lua Snacks.terminal.toggle()<CR>",                            opts )
keymap("n", "<F7>",       "<cmd>DiffviewFileHistoryToggle %<CR>",                             opts )
keymap("n", "<F8>",       "<cmd>DiffviewToggle<CR>",                                          opts )
keymap('n', "<F9>",       "<cmd>IlluminateToggle<CR>",                                        opts )
keymap('n', "<F10>",      "<ESC>A<CR><ESC>:Pastify<CR>",                                      opts )
keymap("n", "<F12>",      "<cmd>Telescope diagnostics<cr>",                                   opts )

keymap("n", "<TAB>",   ">>",  opts)
keymap("n", "<S-TAB>", "<<",  opts)
keymap("v", "<TAB>",   ">gv", opts)
keymap("v", ">",       ">gv", opts)
keymap("v", "<",       "<gv", opts)
keymap("v", "<S-TAB>", "<gv", opts)
-- keymap("i", "<S-Tab>", "<C-d>", opts)


keymap("v", "<M-c>", "y", opts)
keymap("n", "<C-s>", "<cmd>w<cr>", opts)
keymap("n", "<C-z>", "<C-o><C-o>", opts)
-- keymap("i", "<C-s>", "<esc>:w<CR>", opts)
keymap("i", "<C-z>", "<esc><C-o><C-o>", opts)


vim.keymap.set("v", "<C-c>", 'y', opts)
vim.keymap.set("v", "<M-c>", 'y', opts)





keymap("n", "spl",         ":set splitright<CR>:vsplit<CR> ", opts)
keymap("n", "spk",         ":set splitbelow<CR>:split<CR> ",  opts)
keymap("n", "<M-S-Right>", ":vertical resize-5 <CR> ",        opts)
keymap("n", "<M-S-Left>",  ":vertical resize+5 <CR> ",        opts)
keymap("n", "<M-S-Up>",    ":resize-5 <CR> ",                 opts)
keymap("n", "<M-S-Down>",  ":resize+5 <CR> ",                 opts)






-- Global mappings.
-- See `:help vim.diagnostic.*` for documentation on any of the below functions
vim.keymap.set('n', '<space>d', vim.diagnostic.open_float)
vim.keymap.set('n', '[d',       vim.diagnostic.goto_prev)
vim.keymap.set('n', ']d',       vim.diagnostic.goto_next)


vim.api.nvim_create_autocmd('LspAttach', {
    group = vim.api.nvim_create_augroup('UserLspConfig', {}),
    callback = function(ev)
        local bufnr = ev.buf
        local client = vim.lsp.get_client_by_id(ev.data.client_id)

        vim.bo[bufnr].bufhidden = 'hide'

        -- Enable completion triggered by <c-x><c-o>
        vim.bo[bufnr].omnifunc = 'v:lua.vim.lsp.omnifunc'
        local function desc(description)
            return { noremap = true, silent = true, buffer = bufnr, desc = description }
        end

        local range_formatting = function()
            local start_row, _ = unpack(vim.api.nvim_buf_get_mark(0, "<"))
            local end_row, _   = unpack(vim.api.nvim_buf_get_mark(0, ">"))

            vim.lsp.buf.format({
                range = {
                    ["start"] = { start_row - 1, 0 }, -- Adjust to 0-based indexing
                    ["end"]   = { end_row - 1, 0 },   -- Adjust to 0-based indexing
                },
                async = true,
            })

            vim.notify(string.format("LSP Formatting lines %d to %d", start_row, end_row))
            vim.api.nvim_input("<esc>")
        end

        local lsp_opts = { buffer = ev.buf }
        vim.keymap.set('n',          'gd',        vim.lsp.buf.definition,                                                  lsp_opts)
        -- vim.keymap.set('n',          'gd',        "<CMD>Lspsaga goto_definition <CR>",                                                  lsp_opts)
        vim.keymap.set('n',          'gr',        "<cmd>Telescope lsp_references theme=ivy<CR>",                           lsp_opts)
        vim.keymap.set('n',          'gpd',       "<CMD>Lspsaga peek_definition <CR>",                                     lsp_opts)
        vim.keymap.set('n',          'gh',        vim.lsp.buf.hover,                                                       lsp_opts)
        vim.keymap.set('n',          'gH',        vim.lsp.buf.signature_help,                                              lsp_opts)
        vim.keymap.set('n',          'gi',        vim.lsp.buf.implementation,                                              lsp_opts)
        vim.keymap.set('n',          '<space>wa', vim.lsp.buf.add_workspace_folder,                                        lsp_opts)
        vim.keymap.set('n',          '<space>wr', vim.lsp.buf.remove_workspace_folder,                                     lsp_opts)
        vim.keymap.set('n',          '<space>wl', function() print(vim.inspect(vim.lsp.buf.list_workspace_folders())) end, lsp_opts)
        vim.keymap.set('n',          '<space>sw', "<CMD>Lspsaga outline<CR>",                                              lsp_opts)
        vim.keymap.set('n',          '<space>sf', "<CMD>Lspsaga finder<CR>",                                               lsp_opts)
        vim.keymap.set({ 'n', 'v' }, '<SPACE>ca', "<CMD>Lspsaga code_action<CR>",                                          lsp_opts)
        vim.keymap.set('n',          '<space>f',  function() vim.lsp.buf.format { async = true } end,                      lsp_opts)
        vim.keymap.set('v',          '<space>f',  range_formatting,                                                        {buffer = ev.buf, desc = '[lsp] Range Formatting' })

        if client.server_capabilities.inlayHintProvider then
            vim.keymap.set('n', '<space>h', function()
                -- local current_setting = vim.lsp.inlay_hint.is_enabled()
                local is_enabled = vim.lsp.inlay_hint.is_enabled({ bufnr = bufnr })
                vim.lsp.inlay_hint.enable(not is_enabled, {bufnr = bufnr})
            end, desc('[lsp] toggle inlay hints'))
        end

        -- Auto-refresh code lenses
        if not client then
            return
        end
        local function buf_refresh_codeLens()
            vim.schedule(function()
                if client.server_capabilities.codeLensProvider then
                    vim.lsp.codelens.refresh()
                    return
                end
            end)
        end
        local group = vim.api.nvim_create_augroup(string.format('lsp-%s-%s', bufnr, client.id), {})
        if client.server_capabilities.codeLensProvider then
            vim.api.nvim_create_autocmd({ 'InsertLeave', 'BufWritePost', 'TextChanged' }, {
                group = group,
                callback = buf_refresh_codeLens,
                buffer = bufnr,
            })
            buf_refresh_codeLens()
        end
    end,
})






keymap("t", "<ESC>", "<C-\\><C-n>", term_opts)

keymap("n", "ty", "<cmd>BufferLineCycleNext<CR>", opts)
keymap("n", "tr", "<cmd>BufferLineCyclePrev<CR>", opts)
keymap("n", "tt", "<cmd>bd!<CR>", opts)
keymap("n", "td", "<cmd>tabclose<CR>", opts)
keymap("n", "<leader>1", "<cmd>BufferLineGoToBuffer 1<cr>", opts)
keymap("n", "<leader>2", "<cmd>BufferLineGoToBuffer 2<cr>", opts)
keymap("n", "<leader>3", "<cmd>BufferLineGoToBuffer 3<cr>", opts)
keymap("n", "<leader>4", "<cmd>BufferLineGoToBuffer 4<cr>", opts)
keymap("n", "<leader>5", "<cmd>BufferLineGoToBuffer 5<cr>", opts)
keymap("n", "<leader>6", "<cmd>BufferLineGoToBuffer 6<cr>", opts)
keymap("n", "<leader>7", "<cmd>BufferLineGoToBuffer 7<cr>", opts)
keymap("n", "<leader>8", "<cmd>BufferLineGoToBuffer 8<cr>", opts)
keymap("n", "<leader>9", "<cmd>BufferLineGoToBuffer 9<cr>", opts)
keymap("n", "<leader>$", "<cmd>BufferLineGoToBuffer -1<cr>", opts)


keymap("t", "ty", "<C-\\><C-n><cmd>BufferLineCycleNext<CR>", term_opts)
keymap("t", "tr", "<C-\\><C-n><cmd>BufferLineCyclePrev<CR>", term_opts)
keymap("t", "tt", "<C-\\><C-n><cmd>bd!<CR>", term_opts)
keymap("t", "td", "<C-\\><C-n><cmd>tabclose<CR>", term_opts)
keymap("t", "<leader>1", "<C-\\><C-n><cmd>BufferLineGoToBuffer 1<cr>", term_opts)
keymap("t", "<leader>2", "<C-\\><C-n><cmd>BufferLineGoToBuffer 2<cr>", term_opts)
keymap("t", "<leader>3", "<C-\\><C-n><cmd>BufferLineGoToBuffer 3<cr>", term_opts)
keymap("t", "<leader>4", "<C-\\><C-n><cmd>BufferLineGoToBuffer 4<cr>", term_opts)
keymap("t", "<leader>5", "<C-\\><C-n><cmd>BufferLineGoToBuffer 5<cr>", term_opts)
keymap("t", "<leader>6", "<C-\\><C-n><cmd>BufferLineGoToBuffer 6<cr>", term_opts)
keymap("t", "<leader>7", "<C-\\><C-n><cmd>BufferLineGoToBuffer 7<cr>", term_opts)
keymap("t", "<leader>8", "<C-\\><C-n><cmd>BufferLineGoToBuffer 8<cr>", term_opts)
keymap("t", "<leader>9", "<C-\\><C-n><cmd>BufferLineGoToBuffer 9<cr>", term_opts)
keymap("t", "<leader>$", "<C-\\><C-n><cmd>BufferLineGoToBuffer -1<cr>", term_opts)
