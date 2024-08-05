return -- lazy.nvim
{
	{
		"folke/noice.nvim",
		event = "VeryLazy",
		opts = {
			vim.keymap.set("n", "<leader>nd", ":Noice dismiss <CR>"),
			background_color = "#000000",
		},
		dependencies = {
			"MunifTanjim/nui.nvim",
			"rcarriga/nvim-notify",
		},
	},
	{
		"rcarriga/nvim-notify",

		config = function()
			require("notify").setup({
				background_colour = "#000000",
			})
		end,
	},
}
