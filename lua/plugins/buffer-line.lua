return { {
	"akinsho/bufferline.nvim"
	,
	version = "*"
	,
	dependencies = "nvim-tree/nvim-web-devicons"
	,
	after = "catppuccin",
	config = function()
		require('bufferline').setup({
			options = {
				highlights = require("catppuccin.groups.integrations.bufferline").get(),
				mode = 'buffer',
				separator_style = 'thin',


				color_icons = true, -- whether or not to add the filetype icon highlights
				themable = true, -- allows highlight groups to be overriden i.e. sets highlights as default
				indicator = 'underline'
			}
		})
	end
} }
