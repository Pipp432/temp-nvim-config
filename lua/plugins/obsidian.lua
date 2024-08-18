return {
	"epwalsh/obsidian.nvim",
	version = "*", -- recommended, use latest release instead of latest commit
	lazy = true,
	ft = "markdown",
	dependencies = {
		"nvim-lua/plenary.nvim",
	},

	config = function()
		vim.opt.conceallevel = 1
		require("obsidian").setup({

			conceallevel = 1,
			workspaces = {
				{
					name = "Work Vault",
					path = "~/Desktop/Developer-Notes",
				},
			},
			mappings = {
				["<leader>ch"] = {
					action = function()
						return require("obsidian").util.toggle_checkbox()
					end,
					opts = { buffer = true },
				},
			},
		})
	end,
}
