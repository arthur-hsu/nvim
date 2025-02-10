
return{
    "folke/trouble.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    event = 'VeryLazy',
    cmd = "Trouble",
    keys = {
        {
            "<leader>xx",
            "<cmd>Trouble diagnostics toggle<cr>",
            desc = "Diagnostics (Trouble)",
        },
        {
            "<leader>xX",
            "<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
            desc = "Buffer Diagnostics (Trouble)",
        },
        {
            "<leader>cs",
           "<cmd>Trouble symbols toggle focus=false<cr>",
            desc = "Symbols (Trouble)",
        },
        {
            "<leader>cl",
            "<cmd>Trouble lsp toggle focus=false win.position=right<cr>",
            desc = "LSP Definitions / references / ... (Trouble)",
        },
        {
            "<leader>xL",
            "<cmd>Trouble loclist toggle<cr>",
            desc = "Location List (Trouble)",
        },
        {
            "<leader>xQ",
            "<cmd>Trouble qflist toggle<cr>",
            desc = "Quickfix List (Trouble)",
        },
    },
    opts = {
        auto_close      = true,   -- auto close when there are no items
        auto_open       = false,  -- auto open when there are items
        auto_preview    = true,   -- automatically open preview when on an item
        auto_refresh    = true,   -- auto refresh when open
        auto_jump       = false,  -- auto jump to the item when there's only one
        focus           = true,   -- Focus the window when opened
        restore         = true,   -- restores the last location in the list when opening
        follow          = true,   -- Follow the current item
        indent_guides   = true,   -- show indent guides
        max_items       = 200,    -- limit number of items that can be displayed per section
        multiline       = true,   -- render multi-line messages
        pinned          = false,  -- When pinned, the opened trouble window will be bound to the current buffer
        warn_no_results = true,   -- show a warning when there are no results
        open_no_results = false,  -- open the trouble window when there are no results
        icons = {
            indent = {
                fold_open     = "",                     -- icon used for open folds
                fold_closed   = "",                     -- icon used for closed folds

            }
        },
        -- modes = {
        --     preview_float = {
        --         mode = "diagnostics",
        --         preview = {
        --             type = "float",
        --             relative = "editor",
        --             border = "rounded",
        --             title = "Preview",
        --             title_pos = "center",
        --             position = { 0, -2 },
        --             size = { width = 0.3, height = 0.3 },
        --             zindex = 200,
        --         },
        --     },
        -- },
        signs = {
          -- icons / text used for a diagnostic
          error       = "",
          warning     = "",
          hint        = "",
          information = "",
          other       = ""
        },
        use_diagnostic_signs = true         -- enabling this will use the signs defined in your lsp client
    },
    -- config = function ()
    --     local actions = require("telescope.actions")
    --     local open_with_trouble = require("trouble.sources.telescope").open
    --
    --     -- Use this to add more results without clearing the trouble list
    --     local add_to_trouble = require("trouble.sources.telescope").add
    --
    --     local telescope = require("telescope")
    --
    --     telescope.setup({
    --         defaults = {
    --             mappings = {
    --                 i = { ["<c-t>"] = open_with_trouble },
    --                 n = { ["<c-t>"] = open_with_trouble },
    --             },
    --         },
    --     })
    -- end
}
