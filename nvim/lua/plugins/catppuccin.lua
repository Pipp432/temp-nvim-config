return {
	{
		"catppuccin/nvim",
		name = "catppuccin",
		opts = {
			transparent_background = true,
		},
		config = function()
			require("catppuccin").setup({
			transparent_background = true})
			vim.cmd.colorscheme("catppuccin")
		end,
	},
}
