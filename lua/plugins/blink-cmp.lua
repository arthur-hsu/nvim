local has_words_before = function()
    if vim.api.nvim_buf_get_option(0, "buftype") == "prompt" then return false end
    local line, col = unpack(vim.api.nvim_win_get_cursor(0))
    return col ~= 0 and vim.api.nvim_buf_get_text(0, line-1, 0, line-1, col, {})[1]:match("^%s*$") == nil
end

return {
	"saghen/blink.cmp",
	-- optional: provides snippets for the snippet source
    -- enabled = false,
    event = "VeryLazy",
	dependencies = {
        "rafamadriz/friendly-snippets",

    },
    
	-- use a release tag to download pre-built binaries
	version = "1.*",
	-- AND/OR build from source, requires nightly: https://rust-lang.github.io/rustup/concepts/channels.html#working-with-nightly-rust
	-- build = 'cargo build --release',
	-- If you use nix, you can build from source using latest nightly rust with:
	-- build = 'nix run .#build-plugin',
	---@module 'blink.cmp'
	---@type blink.cmp.Config
	opts = {
		keymap = {
            preset = "none",
            -- preset = 'enter',
            --
            -- ["<Tab>"] = {
            --     function(cmp)
            --         if require("copilot.suggestion").is_visible() then
            --             require("copilot.suggestion").accept()
            --             return true
            --         end
            --     end,
            --     'select_next',
            --     'snippet_forward',
            --     'fallback'
            -- },
            -- ["<S-Tab>"] = {
            --     'select_prev',
            --     'snippet_backward',
            --     'fallback'
            -- },

        },
        
		appearance = {
			-- 'mono' (default) for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
			-- Adjusts spacing to ensure icons are aligned
			nerd_font_variant = "mono",
		},
        signature = {
            enabled = true,
            trigger = {
                show_on_insert = true,
            },
            window = {
                show_documentation = true,
                border = 'rounded'
            }
        },
		-- (Default) Only show the documentation popup when manually triggered
		completion = {
            menu = {
                enabled = false,
                -- window = {
                --     auto_show = false,
                -- },
                border = 'rounded',
                draw = {
                    columns = {{ "label", "label_description", gap = 1 }, { "kind_icon"}, {"kind" }, { "source_name" }},
                    -- align_to = "cursor",
                    treesitter = { 'lsp' }
                }
            },
            list = {
                selection = {
                    preselect = false,
                    auto_insert = true
                }
            },
            documentation = {
                auto_show = true,
                auto_show_delay_ms = 100,
                window = { border = 'rounded' },
            },
        },
        -- snippets = { preset = 'luasnip' },
		-- Default list of enabled providers defined so that you can extend it
		-- elsewhere in your config, without redefining it, due to `opts_extend`
		sources = {
			default = { "lsp", "path", "snippets", "buffer" },
		},

		-- (Default) Rust fuzzy matcher for typo resistance and significantly better performance
		-- You may use a lua implementation instead by using `implementation = "lua"` or fallback to the lua implementation,
		-- when the Rust fuzzy matcher is not available, by using `implementation = "prefer_rust"`
		--
		-- See the fuzzy documentation for more information
		fuzzy = { implementation = "prefer_rust_with_warning" },
        cmdline = {
            enabled = false,
            sources = function()
                local type = vim.fn.getcmdtype()
                if type == '/' or type == '?' then return { 'buffer' } end
                if type == ':' or type == '@' then return { 'path', 'cmdline' } end
                return {}
            end,
            completion = {
                menu = {
                    auto_show = true,
                },
            }
        }

	},
	opts_extend = { "sources.default" },
}
