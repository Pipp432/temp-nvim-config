return {
	'nvim-lualine/lualine.nvim',
	dependencies = { 'nvim-tree/nvim-web-devicons' },
	config = function()
		local colors = {
			red = '#ca1243',
			grey = '#a0a1a7',
			black = '#222536',
			text = "#f3f3f3",

			background = '#24283b',
			light_green = '#83a598',
			orange = '#ff9e64',
			green = '#8ec07c',
			sunset_purple = "#bb9af7"
		}

		local theme = {
			normal = {
				a = { fg = colors.text, bg = colors.black },
				b = { fg = colors.text, bg = colors.black },
				c = { fg = colors.black, bg = colors.background },
				z = { fg = colors.text, bg = colors.black },
			},
			command = { a = { fg = colors.black, bg = "#7aa2f7" } },
			insert = { a = { fg = colors.black, bg = colors.sunset_purple } },
			visual = { a = { fg = colors.black, bg = colors.orange } },
			replace = { a = { fg = colors.black, bg = colors.red } },
		}

		local empty = require('lualine.component'):extend()
		function empty:draw(default_highlight)
			self.status = ''
			self.applied_separator = ''
			self:apply_highlights(default_highlight)
			self:apply_section_separators()
			return self.status
		end

		-- Put proper separators and gaps between components in sections
		local function process_sections(sections)
			for name, section in pairs(sections) do
				local left = name:sub(9, 10) < 'x'
				for pos = 1, name ~= 'lualine_z' and #section or #section - 1 do
					table.insert(section, pos * 2, { empty, color = { fg = "#98FBCB", bg = "#98FBCB" } })
				end
				for id, comp in ipairs(section) do
					if type(comp) ~= 'table' then
						comp = { comp }
						section[id] = comp
					end
					comp.separator = left and { right = '' } or { left = '' }
				end
			end
			return sections
		end

		local function search_result()
			if vim.v.hlsearch == 0 then
				return ''
			end
			local last_search = vim.fn.getreg('/')
			if not last_search or last_search == '' then
				return ''
			end
			local searchcount = vim.fn.searchcount { maxcount = 9999 }
			return last_search .. '(' .. searchcount.current .. '/' .. searchcount.total .. ')'
		end

		local function modified()
			if vim.bo.modified then
				return '+'
			elseif vim.bo.modifiable == false or vim.bo.readonly == true then
				return '-'
			end
			return ''
		end

		require('lualine').setup {
			options = {
				theme = theme,
				component_separators = '',
				section_separators = { left = '', right = '' },
			},
			sections = process_sections {
				lualine_a = { 'mode' },
				lualine_b = {
					{ 'branch',
						icon = '',
						color = { fg = colors.orange },
					},
					'diff',
					{
						'diagnostics',
						source = { 'nvim' },
						sections = { 'error' },
						diagnostics_color = { error = { bg = colors.red, fg = colors.text } },
					},
					{
						'diagnostics',
						source = { 'nvim' },
						sections = { 'warn' },
						diagnostics_color = { warn = { bg = colors.orange, fg = colors.text } },
					},
					{ 'filename', file_status = false,        path = 1 },
					{ modified,   color = { bg = colors.red } },
					{
						'%w',
						cond = function()
							return vim.wo.previewwindow
						end,
					},
					{
						'%r',
						cond = function()
							return vim.bo.readonly
						end,
					},
					{
						'%q',
						cond = function()
							return vim.bo.buftype == 'quickfix'
						end,
					},
				},
				lualine_c = {},
				lualine_x = {},
				lualine_y = { search_result, 'filetype' },
				lualine_z = { '%l:%c', '%p%%/%L' },
			},
			inactive_sections = {
				lualine_c = { '%f %y %m' },
				lualine_x = {},
			},
		}
	end
}
