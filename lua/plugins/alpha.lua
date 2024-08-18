return {
	"goolord/alpha-nvim",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	config = function()
		local alpha = require("alpha")
		require("alpha").setup(require("alpha.themes.startify").config)
		local dashboard = require("alpha.themes.dashboard")
		dashboard.section.header.val = {
			"███████╗██╗   ██╗ ██████╗ ██╗  ████████╗       ██   ██         ",
			"██╔════╝██║   ██║██╔═══██╗██║  ╚══██╔══╝                       ",
			"█████╗  ██║   ██║██║   ██║██║     ██║      ██           ██     ",
			"██╔══╝  ╚██╗ ██╔╝██║   ██║██║     ██║        ██       ██       ",
			"███████╗ ╚████╔╝ ╚██████╔╝███████╗██║          ███████         ",
			"╚══════╝  ╚═══╝   ╚═════╝ ╚══════╝╚═╝                          ",
		}
		dashboard.section.buttons.val = {
			dashboard.button("e", "📄  > New file", ":ene <BAR> startinsert <CR>"),
			dashboard.button("f", "🔍  > Find file", ":cd $HOME/Workspace | Telescope find_files<CR>"),
			dashboard.button("r", "📂  > Recent", ":Telescope oldfiles<CR>"),
			dashboard.button("s", "⚙️   > Configurations", ":e $MYVIMRC | :cd %:p:h | split . | wincmd k | pwd<CR>"),
			dashboard.button("q", "🚫  > Quit NVIM", ":qa<CR>"),
		}

		alpha.setup(dashboard.opts)
	end,
}
