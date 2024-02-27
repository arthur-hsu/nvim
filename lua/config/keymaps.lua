local opts = { noremap = true, silent = true }
-- Modes
--   normal_mode = "n",
--   insert_mode = "i",
--   visual_mode = "v",
--   visual_block_mode = "x",
--   term_mode = "t",
--   command_mode = "c",


local term_opts = { silent = true }

-- Shorten function name
local keymap = vim.api.nvim_set_keymap


if vim.loop.os_uname().sysname == 'Linux' or 'Darwin' then
    keymap("n", "rc", ":Telescope file_browser path=$HOME/.config/nvim/lua<CR>", opts)
    keymap("c", "Test", ":e $HOME/Desktop/test.py<CR>", opts)
elseif vim.loop.os_uname().sysname == 'Windows_NT' then
    keymap("n", "rc", ":Telescope file_browser path=$HOME\\AppData\\Local\\nvim\\lua<CR>", opts)
    keymap("c", "Test", ":e $HOME\\Desktop\\test.py<CR>", opts)
end

keymap("n", "<leader>jq", "<cmd>%!jq --indent 4<CR>", opts)
keymap("n", "<leader>L", "<cmd>Lazy<CR>", opts)
keymap("n", "<leader>mc", "<cmd>Mason<CR>", opts)
keymap("n", "<leader>nh", "<cmd>let @/ = ''<CR><cmd>noh<CR>", opts)
keymap("n", "<F2>", ":terminal<CR>i", opts)
keymap("n", "<F3>", "<cmd>Telescope<cr>", opts)
keymap('n', '<F4>', '<Cmd>TodoTelescope<CR>',opts)
keymap("n", "<F5>", ":RunCode<CR>", opts)
keymap("n", "<F6>", "<cmd>DiffviewFileHistory %<CR>", opts)
keymap("n", "<F7>", "<cmd>Telescope undo<cr>", opts)
keymap("n", "<F8>", "<cmd>TroubleToggle<cr>", opts)
keymap('n', "<F9>", "<ESC>A<CR><ESC>:Pastify<CR>", opts)
keymap('n', "<F10>", "<cmd>CursorWordToggle<CR>", opts)
keymap("n", "<F12>", "<cmd>DiffviewOpen<CR>", opts)
-- keymap("n", "<F12>", ":StartupTime<CR>",opts)
keymap("n", "<TAB>", ">>", opts)
keymap("n", "<S-TAB>", "<<", opts)
keymap("v", "<TAB>", ">gv", opts)
keymap("v", ">", ">gv", opts)
keymap("v", "<S-TAB>", "<gv", opts)
keymap("v", "<", "<gv", opts)

keymap("v", "<M-c>", "y", opts)
keymap("n", "<C-s>", ":w<CR>", opts)
keymap("n", "<C-z>", "<C-o><C-o>", opts)
keymap("i", "<C-s>", "<esc>:w<CR>", opts)
keymap("i", "<C-z>", "<esc><C-o><C-o>", opts)






keymap("n", "spl", ":set splitright<CR>:vsplit<CR> ", opts)
keymap("n", "spk", ":set splitbelow<CR>:split<CR> ", opts)
keymap("n", "<M-S-Right>", ":vertical resize-5 <CR> ", opts)
keymap("n", "<M-S-Left>", ":vertical resize+5 <CR> ", opts)
keymap("n", "<M-S-Up>", ":resize-5 <CR> ", opts)
keymap("n", "<M-S-Down>", ":resize+5 <CR> ", opts)






-- Global mappings.
-- See `:help vim.diagnostic.*` for documentation on any of the below functions
vim.keymap.set('n', '<space>d', vim.diagnostic.open_float)
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next)

-- Use LspAttach autocommand to only map the following keys
-- after the language server attaches to the current buffer
vim.api.nvim_create_autocmd('LspAttach', {
    group = vim.api.nvim_create_augroup('UserLspConfig', {}),
    callback = function(ev)
        -- Enable completion triggered by <c-x><c-o>
        vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'

        local opts = { buffer = ev.buf }
        -- Buffer local mappings.

        vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
        vim.keymap.set('n', 'gr', "<cmd>Telescope lsp_references <CR>", {})
        -- vim.keymap.set('n', 'gr', "<cmd>lua require'telescope.builtin'.lsp_references(require('telescope.themes').get_dropdown({}))<cr>", {})
        vim.keymap.set('n', 'gpd', "<CMD>Lspsaga peek_definition<CR>", opts)
        vim.keymap.set('n', 'gh', vim.lsp.buf.hover, opts)
        vim.keymap.set('n', 'gH', vim.lsp.buf.signature_help, opts)
        vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
        vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, opts)
        vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, opts)
        vim.keymap.set('n', '<space>wl', function() print(vim.inspect(vim.lsp.buf.list_workspace_folders())) end, opts)
        vim.keymap.set('n', '<space>rn', "<CMD>lua vim.lsp.buf.rename()<CR>", opts)
        --vim.keymap.set('n', '<space>rn', "<CMD>Lspsaga rename<CR>", opts)
        vim.keymap.set('n', '<space>sw', "<CMD>Lspsaga outline<CR>", opts)
        vim.keymap.set('n', '<space>sf', "<CMD>Lspsaga finder<CR>", opts)
        vim.keymap.set({ 'n', 'v' }, '<SPACE>ca', "<CMD>Lspsaga code_action<CR>", opts)
        vim.keymap.set('n', '<space>f', function() vim.lsp.buf.format { async = true } end, opts)
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
