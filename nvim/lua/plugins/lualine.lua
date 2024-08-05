local nvimbattery = {
  function()
    return require("battery").get_status_line()
  end,
}
return {
	'nvim-lualine/lualine.nvim',
	dependencies = { 'nvim-tree/nvim-web-devicons' },
	config = function()
		require('lualine').setup({
			sections = { lualine_a = nvimbattery },
			options={
				theme='dracula'
			}
		})
	end,
}
