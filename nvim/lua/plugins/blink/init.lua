return {
	'saghen/blink.cmp',

	version = '1.*',
	opts = {
		keymap = { preset = 'default' },

		appearance = {
			nerd_font_variant = 'mono'
		},

		completion = {
			documentation = {
				auto_show = false
			},
			menu = {
				draw = {
					-- We don't need label_description now because label and label_description are already
					-- combined together in label by colorful-menu.nvim.
					columns = { { "kind_icon" }, { "label", gap = 1 } },
					components = {
						label = {
							text = function(ctx)
								return require("colorful-menu").blink_components_text(ctx)
							end,
							highlight = function(ctx)
								return require("colorful-menu").blink_components_highlight(ctx)
							end,
						},
					},
				},
			}
		},

		sources = {
			default = { 'lsp', 'path', 'snippets', 'buffer' },
		},

		signature = { enabled = true },


		fuzzy = { implementation = "prefer_rust_with_warning" }
	},
	opts_extend = { "sources.default" }
}
