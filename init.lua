vim.opt.termguicolors = true
vim.cmd("set tabstop=2")
vim.cmd("set softtabstop=2")
vim.cmd("set shiftwidth=2")
vim.g.mapleader = " "
vim.opt.nu = true
vim.opt.relativenumber = true
vim.api.nvim_set_hl(0, 'LineNrAbove', { fg = '#03fcd3' })
vim.api.nvim_set_hl(0, 'LineNr', { fg = 'yellow' })
vim.api.nvim_set_hl(0, 'LineNrBelow', { fg = '#03fcd3' })
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup("plugins")
require("hardtime").setup({})
vim.keymap.set('n', '<leader>oo', '<CMD>ObsidianOpen<CR>')
vim.keymap.set('n', 'gb', '<CMD>BufferLinePick<CR>')
vim.keymap.set('n', '<leader>ts', '<CMD>BufferLinePickClose<CR>')
vim.keymap.set('n', '<Tab>', '<CMD>BufferLineCycleNext<CR>')
vim.keymap.set('n', '<S-Tab>', '<CMD>BufferLineCyclePrev<CR>')
vim.keymap.set('n', ']b', '<CMD>BufferLineMoveNext<CR>')
vim.keymap.set('n', '[b', '<CMD>BufferLineMovePrev<CR>')
vim.keymap.set('n', 'gs', '<CMD>BufferLineSortByDirectory<CR>')
vim.keymap.set('n', '<leader>bd', '<CMD>bd<CR>')
vim.keymap.set('n', '<leader>fs', '<CMD>FlutterRun<CR>')
vim.keymap.set('n', '<leader>fr', '<CMD>FlutterReload<CR>')
vim.keymap.set('n','<leader>fR', '<CMD>FlutterRestart<CR>')
