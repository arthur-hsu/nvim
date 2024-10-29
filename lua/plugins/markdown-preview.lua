return{
    {
        'arthur-hsu/pastify.nvim',
        ft = { "markdown","toml" },
        cmd = { 'Pastify' },
        config = function ()
            require('pastify').setup {
                opts = {
                    absolute_path = false, -- use absolute or relative path to the working directory
                    apikey        = 'c88b2f2193424aa23e2b6f870d544176', -- Api key, required for online saving
                    local_path    = '/screenshot/', -- The path to put local files in, ex ~/Projects/<name>/assets/images/<imgname>.png
                    save          = 'local', -- Either 'local' or 'online'
                },
                ft = { -- Custom snippets for different filetypes, will replace $IMG$ with the image url
                    html     = '<img src="$IMG$" alt="">',
                    markdown = '![image]($IMG$)',
                    tex      = [[\includegraphics[width=\linewidth]{$IMG$}]],
                },
            }
        end
    },
    {
        "iamcco/markdown-preview.nvim",
        ft = { "markdown" },
        cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
        build = function() vim.fn["mkdp#util#install"]() end,
        config = function()
            vim.keymap.set('n', '<leader>md', "<CMD>MarkdownPreviewToggle<CR>", { noremap = true, silent = true })
            vim.g.mkdp_auto_close        = true
            vim.g.mkdp_open_to_the_world = false
            vim.g.mkdp_open_ip           = "127.0.0.1"
            vim.g.mkdp_port              = "8888"
            --vim.g.mkdp_browser         = ""
            vim.g.mkdp_echo_preview_url  = false
            vim.g.mkdp_page_title        = "${name}"
            vim.g.mkdp_theme             = 'dark'
        end
    }
}
