return {

	{
		"hrsh7th/cmp-nvim-lsp"
	},
	{
		"L3MON4D3/LuaSnip",
		dependencies = {
			"saadparwaiz1/cmp_luasnip",
			"rafamadriz/friendly-snippets",
		},

		config = function()
			local luasnip = require("luasnip")
			require("luasnip.loaders.from_lua").lazy_load()
			vim.keymap.set({ "i", "s" }, "<C-l>", function()
				if luasnip.expand_or_jumpable() then
					luasnip.expand_or_jump()
				end
			end, { desc = "Snippet next argument", silent = true })

			vim.keymap.set({ "i", "s" }, "<C-h>", function()
				if luasnip.jumpable(-1) then
					luasnip.jump(-1)
				end
			end, { desc = "Snippet previous argument", silent = true })

			vim.keymap.set("i", "<C-j>", function()
				if luasnip.choice_active() then
					luasnip.change_choice(1)
				end
			end, { desc = "Snippet next choice", silent = true })

			vim.keymap.set("i", "<C-k>", function()
				if luasnip.choice_active() then
					luasnip.change_choice(-1)
				end
			end, { desc = "Snippet previous choice", silent = true })

			local s = luasnip.snippet
			local fmt = require("luasnip.extras.fmt").fmt
			local f = luasnip.function_node
			local i = luasnip.insert_node
			local d = luasnip.dynamic_node
			local sn = luasnip.snippet_node

			local freezed_model = s(
				"freezed",
				fmt([[
@freezed
class {} with _${}{{
  const {}._();
  const factory {}({{
  }}) = _{};
  factory {}.fromJson(dynamic json) => _${}FromJson(json);
}}
					]], {
					i(1, "ModelName"),
					f(function(args)
						return args[1][1] or ""
					end, { 1 }),

					f(function(args)
						return args[1][1] or ""
					end, { 1 }),
					f(function(args)
						return args[1][1] or ""
					end, { 1 }),
					f(function(args)
						return args[1][1] or ""
					end, { 1 }),
					f(function(args)
						return args[1][1] or ""
					end, { 1 }),
					f(function(args)
						return args[1][1] or ""
					end, { 1 }),
				}))
			local freezed_attribute = s(
				"freezed_attribute",
				fmt([[
@Default({}) final {} {},
				]],
					{
						i(1, "DefaultValue"),
						i(2, "AttributeType"),
						i(3, "AttributeName"),
					}))

			local react_component = s(
				"react_component",
				fmt([[
				export default function {1} (){{
				return
				}}
				]],
					{
						f(function() return vim.fn.expand("%:t:r") end),
					}))
			local zustand_store = s(
				"zustand_store",
				fmt([[
import {{ create }} from 'zustand';

interface {1}Type {{
}}

const initialState = {{
}};

export const {2} = create<{3}Type>((set) => ({{
}}));
					]], {
					f(function() return vim.fn.expand("%:t:r") end),
					f(function() return vim.fn.expand("%:t:r") end),
					f(function() return vim.fn.expand("%:t:r") end) })
			)
			luasnip.add_snippets("all", { freezed_model, freezed_attribute, react_component, zustand_store })
		end
	},
	{
		"hrsh7th/nvim-cmp",
		config = function()
			local cmp = require("cmp")
			require("luasnip.loaders.from_vscode").lazy_load { paths = { "~/.config/nvim/snippets/" } }
			cmp.setup({
				snippet = {
					expand = function(args)
						require("luasnip").lsp_expand(args.body)
					end,
				},
				window = {
					completion = cmp.config.window.bordered({
						border = "double",
						winhighlight = "Normal:Pmenu,FloatBorder:Pmenu,CursorLine:PmenuSel,Search:None",
					}),
					documentation = cmp.config.window.bordered({
						border = "double"
					}),
				},
				mapping = cmp.mapping.preset.insert({
					["<C-b>"] = cmp.mapping.scroll_docs(-4),
					["<C-f>"] = cmp.mapping.scroll_docs(4),
					["<C-Space>"] = cmp.mapping.complete(),
					["<C-e>"] = cmp.mapping.abort(),
					["<CR>"] = cmp.mapping.confirm({ select = true }),
				}),
				sources = cmp.config.sources({

					{ name = "luasnip" }, -- For luasnip users.
					{ name = "nvim_lsp" },
				}, {
					{ name = "buffer" },
				}),
			})
		end,
	},
}
