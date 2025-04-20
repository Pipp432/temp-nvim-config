return {
	"akinsho/bufferline.nvim"
	,
	version = "*"
	,
	dependencies = "nvim-tree/nvim-web-devicons"
	,
	config = function()
		require('bufferline').setup({
			options = {

				hover = {
					enabled = true,
					delay = 150,
					reveal = { 'close' }
				},
				show_buffer_close_icons = false,
				mode = 'buffer',
				separator_style = 'slope',
				show_close_icon = false,
				color_icons = true,
				themable = true,
				indicator = { style = 'underline' }
			}
		})
	end
}
