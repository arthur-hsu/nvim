return{
    {
        'NvChad/nvim-colorizer.lua',
        event = 'VeryLazy',
        config = function ()
            --require'colorizer'.setup({})
            require("colorizer").attach_to_buffer(0, { mode = "background", css = true})
        end
    },
    {
        'xiyaowong/transparent.nvim',
        --lazy = false,
        --event = 'VeryLazy',
        event = { "BufReadPost", "BufNewFile" },
        priority = 1000,
        opts ={
            exclude_groups = {'bufferline'},
        },
        config= function ()
            require('transparent').clear_prefix('lualine')
        end
    },
    {
        'nvim-tree/nvim-web-devicons',
        lazy = true,
        --event = 'VeryLazy',
    },
    {
        'dstein64/vim-startuptime',
        event = 'VeryLazy',
    },
    {
        "nathom/filetype.nvim",
        --lazy=true
        event = 'VeryLazy',
    },
    {
        "sindrets/diffview.nvim",
        event = 'VeryLazy',
    },
    {
        'scrooloose/nerdcommenter',
        event = 'VeryLazy',
    },
    {
        'iamcco/markdown-preview.nvim',
        lazy = true,
        event = {'BufEnter *.md', "BufRead *.md", "BufNewFile *.md" },
        build = "cd app && npm install",
        --build = function() vim.fn["mkdp#util#install"]() end,
        config = function()
            --vim.fn["mkdp#util#install"]()
            vim.keymap.set('n', '<leader>md', "<CMD>MarkdownPreview<CR>", { noremap = true, silent = true })
            vim.g.mkdp_auto_close = true
            vim.g.mkdp_open_to_the_world = false
            vim.g.mkdp_open_ip = "127.0.0.1"
            vim.g.mkdp_port = "8888"
            --vim.g.mkdp_browser = ""
            vim.g.mkdp_echo_preview_url = false
            vim.g.mkdp_page_title = "${name}"
            vim.g.mkdp_theme = 'dark'
        end,
    },
    {
        'TobinPalmer/pastify.nvim',
        lazy = true,
        event = {'BufEnter *.md', "BufRead *.md", "BufNewFile *.md" },
        cmd = { 'Pastify' },
        config = function ()
            require('pastify').setup {
                opts = {
                    absolute_path = false, -- use absolute or relative path to the working directory
                    apikey = 'c88b2f2193424aa23e2b6f870d544176', -- Api key, required for online saving
                    local_path = '/Document/screenshot/', -- The path to put local files in, ex ~/Projects/<name>/assets/images/<imgname>.png
                    save = 'local', -- Either 'local' or 'online'
                },
                ft = { -- Custom snippets for different filetypes, will replace $IMG$ with the image url
                    html = '<img src="$IMG$" alt="">',
                    markdown = '![image]($IMG$)',
                    tex = [[\includegraphics[width=\linewidth]{$IMG$}]],
                },
            }
        end
    },
    {
        'lithammer/nvim-pylance',
        lazy=true,
    },
    {
        'github/copilot.vim',
        event = { "BufReadPost", "BufNewFile" },
        enabled=false,
        config = function ()
            vim.cmd [[imap <silent><script><expr> <C-a> copilot#Accept("\<CR>")]]
            vim.g.copilot_no_tab_map = true
            vim.cmd[[highlight CopilotSuggestion guifg=#96ff00 guibg=#162a33 ctermfg=8]]
        end,
    },
    {
        "zbirenbaum/copilot.lua",
        cmd = "Copilot",
        event = { "BufReadPost", "BufNewFile" },
        --event = "InsertEnter",
        config = function()
            require("copilot").setup({
                panel = {
                    enabled = true,
                    auto_refresh = true,
                    keymap = {
                        jump_prev = "[[",
                        jump_next = "]]",
                        accept = "<CR>",
                        refresh = "gr",
                        open = "<M-CR>"
                    },
                    layout = {
                        position = "bottom", -- | top | left | right
                        ratio = 0.4
                    },
                },
                suggestion = {
                    enabled = true,
                    auto_trigger = true,
                    debounce = 75,
                    keymap = {
                        accept = "<M-l>",
                        accept_word = false,
                        accept_line = false,
                        next = "<M-]>",
                        prev = "<M-[>",
                        dismiss = "<C-e>",
                    },
                },
                filetypes = {
                    yaml = false,
                    markdown = true,
                    help = false,
                    gitcommit = false,
                    gitrebase = false,
                    hgcommit = false,
                    svn = false,
                    cvs = false,
                    ["."] = false,
                },
                copilot_node_command = 'node', -- Node.js version must be > 16.x
                server_opts_overrides = {
                    trace = "verbose",
                    settings = {
                        advanced = {
                            listCount = 10, -- #completions for panel
                            inlineSuggestCount = 3, -- #completions for getCompletions
                        }
                    },
                }
            })
        end,
    }
}
