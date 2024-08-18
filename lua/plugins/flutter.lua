return {
	{
		"akinsho/flutter-tools.nvim",
		lazy = false,
		dependencies = {
			"nvim-lua/plenary.nvim",
			"stevearc/dressing.nvim", -- optional for vim.ui.select
		},
		config = function()
			require("flutter-tools").setup({

				lsp = {
					color = { -- show the derived colours for dart variables
						enabled =true, -- whether or not to highlight color variables at all, only supported on flutter >= 2.10
						virtual_text = true, -- show the highlight using virtual text
						virtual_text_str = "■", -- the virtual text character to highlight
					},
					widget_guides = {
						enabled = true,
					}
				},
			})
		end,
	},
}
