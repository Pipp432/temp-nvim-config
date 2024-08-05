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
					path = "~/Desktop/Obsidian-Vaults/Work-Vault",
				},
				{
					name = "Personal Vault",
					path = "~/Desktop/Obsidian-Vaults/Personal-Vault",
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
