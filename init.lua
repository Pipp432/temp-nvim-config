vim.opt.termguicolors = true
vim.cmd("set tabstop=2")
vim.cmd("set softtabstop=2")
vim.cmd("set shiftwidth=2")
vim.g.mapleader = " "
vim.opt.nu = true
vim.opt.relativenumber = true
vim.lsp.handlers['textDocument/hover'] = vim.lsp.with(vim.lsp.handlers.hover, { border = 'rounded' })
vim.lsp.handlers['textDocument/signatureHelp'] = vim.lsp.with(vim.lsp.handlers.signature_help, { border = 'rounded' })
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

vim.api.nvim_set_hl(0, 'LineNrAbove', { fg = '#03fcd3' })
vim.api.nvim_set_hl(0, 'LineNr', { fg = 'yellow' })
vim.api.nvim_set_hl(0, 'LineNrBelow', { fg = '#bb9af7' })
vim.api.nvim_create_autocmd({ "FIleType" }, { pattern = "tex", command = "TSBufDisable highlight" })
vim.keymap.set('n', '<leader>oo', '<CMD>ObsidianOpen<CR>')
vim.keymap.set('n', 'gb', '<CMD>BufferLinePick<CR>')
vim.keymap.set('n', '<leader>ts', '<CMD>BufferLinePickClose<CR>')
vim.keymap.set('n', '<Tab>', '<CMD>BufferLineCycleNext<CR>')
vim.keymap.set('n', '<S-Tab>', '<CMD>BufferLineCyclePrev<CR>')
vim.keymap.set('n', ']b', '<CMD>BufferLineMoveNext<CR>')
vim.keymap.set('n', '[b', '<CMD>BufferLineMovePrev<CR>')
vim.keymap.set('n', 'gs', '<CMD>BufferLineSortByDirectory<CR>')
vim.keymap.set('n', '<leader>bd', '<CMD>bd<CR>')
vim.keymap.set('n', '<leader>s|', '<CMD>vsplit<CR>')
vim.keymap.set('n', '<leader>e', '<CMD>:lua Snacks.picker.explorer()<CR>')
vim.keymap.set('n', '<leader>fs', '<CMD>FlutterRun --flavor develop<CR>')
vim.keymap.set('n', '<leader>fd', '<CMD>FlutterDetach<CR>')
vim.keymap.set('n', '<leader>fr', '<CMD>FlutterReload<CR>')
vim.keymap.set('n', '<leader>fR', '<CMD>FlutterRestart<CR>')
vim.keymap.set('n', '<leader>js', function()
	vim.lsp.buf.code_action({
		context = { only = { 'source.generate.toString' } },
		apply = true,
	})
end)

vim.keymap.set('n', '<leader>jh', function()
	vim.lsp.buf.code_action({
		context = { only = { 'source.generate.hashCodeEquals' } },
		apply = true,
	})
end)

local config = {
	cmd = { '/path/to/jdt-language-server/bin/jdtls' },
	root_dir = vim.fs.dirname(vim.fs.find({ 'gradlew', '.git', 'mvnw' }, { upward = true })[1]),
}
vim.g.transparency = 0.9
vim.g.neovide_show_border = false
if vim.g.neovide then
	vim.keymap.set('n', '<D-s>', ':w<CR>') -- Save
	vim.keymap.set('v', '<D-c>', '"+y')   -- Copy
	vim.keymap.set('n', '<D-v>', '"+P')   -- Paste normal mode
	vim.keymap.set('v', '<D-v>', '"+P')   -- Paste visual mode
	vim.keymap.set('c', '<D-v>', '<C-R>+') -- Paste command mode
	vim.keymap.set('i', '<D-v>', '<C-R>+') -- Paste insert mode
end

vim.api.nvim_create_autocmd("LspProgress", {
  ---@param ev {data: {client_id: integer, params: lsp.ProgressParams}}
  callback = function(ev)
    local spinner = { "⠋", "⠙", "⠹", "⠸", "⠼", "⠴", "⠦", "⠧", "⠇", "⠏" }
    vim.notify(vim.lsp.status(), "info", {
      id = "lsp_progress",
      title = "LSP Progress",
      opts = function(notif)
        notif.icon = ev.data.params.value.kind == "end" and " "
          or spinner[math.floor(vim.uv.hrtime() / (1e6 * 80)) % #spinner + 1]
      end,
    })
  end,
})
