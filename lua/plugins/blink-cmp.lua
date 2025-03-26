return {
	"saghen/blink.cmp",
	-- optional: provides snippets for the snippet source
    enabled = false,
	dependencies = {
        "rafamadriz/friendly-snippets",
        {
            "onsails/lspkind-nvim",
            config = function ()
                require('lspkind').init({
                    symbol_map = {
                        Copilot = "",
                    },
                })
            end
        },

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
            preset = 'enter',

            ["<Tab>"] = {
                function(cmp)
                    if require("copilot.suggestion").is_visible() then
                        require("copilot.suggestion").accept()
                        return true
                    end
                end,
                'select_next',
                'snippet_forward',
                'fallback'
            },
            ["<S-Tab>"] = {
                'select_prev',
                'snippet_backward',
                'fallback'
            },

        },
        
		appearance = {
			-- 'mono' (default) for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
			-- Adjusts spacing to ensure icons are aligned
			nerd_font_variant = "mono",
		},
        signature = {
            enabled = true,
            window = {
                show_documentation = true,
                border = 'rounded'
            }
        },
		-- (Default) Only show the documentation popup when manually triggered
		completion = {
            documentation = { auto_show = true, window = { border = 'rounded' }},
            menu = {
                border = 'rounded',
                draw = {
                    columns = {{ "label", "label_description", gap = 1 }, { "kind_icon"}, {"kind" }, { "source_name" }},
                    components = {
                        
                        -- source_name = {
                        --     text = function(ctx)
                        --         
                        --         if ctx.source_name == "LSP" then
                        --             return ctx.item
                        --         end
                        --         return ctx.source_name
                        --     end,
                        --     highlight = "BlinkCmpSource",
                        -- },
                        kind_icon = {
                            text = function(ctx)
                                local lspkind = require("lspkind")
                                local icon = ctx.kind_icon
                                if vim.tbl_contains({ "Path" }, ctx.source_name) then
                                    local dev_icon, _ = require("nvim-web-devicons").get_icon(ctx.label)
                                    if dev_icon then
                                        icon = dev_icon
                                    end
                                else
                                    icon = require("lspkind").symbolic(ctx.kind, {
                                        mode = "symbol",
                                   })
                                end
                                

                                return icon .. ctx.icon_gap
                            end,
                            -- Optionally, use the highlight groups from nvim-web-devicons
                            -- You can also add the same function for `kind.highlight` if you want to
                            -- keep the highlight groups in sync with the icons.
                            highlight = function(ctx)
                                local hl = "BlinkCmpKind" .. ctx.kind
                                or require("blink.cmp.completion.windows.render.tailwind").get_hl(ctx)
                                if vim.tbl_contains({ "Path" }, ctx.source_name) then
                                    local dev_icon, dev_hl = require("nvim-web-devicons").get_icon(ctx.label)
                                    if dev_icon then
                                        hl = dev_hl
                                    end
                                end
                                return hl
                            end,
                        }
                    }
                }
            },
        },
        snippets = { preset = 'luasnip' },
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
