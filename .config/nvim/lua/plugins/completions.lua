-- nvim-cmp Manages the pop-up window that will show completions

return {
	-- cmp lsp
	{
		"hrsh7th/cmp-nvim-lsp",
	},
	{
		"onsails/lspkind.nvim",
	},
	-- Snippet engine
	{
		"L3MON4D3/LuaSnip",
		dependencies = {
			"saadparwaiz1/cmp_luasnip",
			"rafamadriz/friendly-snippets", -- Community-based snippet database
		},
	},
	-- Completion engine
	{
		"hrsh7th/nvim-cmp",
		config = function()
			local cmp = require("cmp")
      local luasnip = require("luasnip")
			require("luasnip.loaders.from_vscode").lazy_load() -- To load the vs code snippets for luasnip

			-- For fancy icons, lspkind-nvim is used
			-- local lspkind = require("lspkind")

			cmp.setup({
				-- Add snippet engine
				snippet = {
					-- REQUIRED - you must specify a snippet engine
					expand = function(args)
						require("luasnip").lsp_expand(args.body) -- For `luasnip` users.
					end,
				},
				-- Add the source of the completion
				formatting = {
					fields = { "abbr", "menu", "kind" },
					format = function(entry, item)
						-- Define menu shorthand for different completion sources.
						local menu_icon = {
							nvim_lsp = "[LSP]",
							nvim_lua = "[Lua]",
							luasnip = "[LuaSnip]",
							buffer = "[Buffer]",
							path = "[PATH]",
							latex_symbols = "[Latex]",
						}
						-- Set the menu "icon" to the shorthand for each completion source.
						item.menu = menu_icon[entry.source.name]

						-- Set the fixed width of the completion menu to 60 characters.
						-- fixed_width = 20

						-- Set 'fixed_width' to false if not provided.
						fixed_width = fixed_width or false

						-- Get the completion entry text shown in the completion window.
						local content = item.abbr

						-- Set the fixed completion window width.
						if fixed_width then
							vim.o.pumwidth = fixed_width
						end

						-- Get the width of the current window.
						local win_width = vim.api.nvim_win_get_width(0)

						-- Set the max content width based on either: 'fixed_width'
						-- or a percentage of the window width, in this case 20%.
						-- We subtract 10 from 'fixed_width' to leave room for 'kind' fields.
						local max_content_width = fixed_width and fixed_width - 10 or math.floor(win_width * 0.2)

						-- Truncate the completion entry text if it's longer than the
						-- max content width. We subtract 3 from the max content width
						-- to account for the "..." that will be appended to it.
						if #content > max_content_width then
							item.abbr = vim.fn.strcharpart(content, 0, max_content_width - 3) .. "..."
						else
							item.abbr = content .. (" "):rep(max_content_width - #content)
						end
						return item
					end,
					-- },
					-- symbol_map = {
					--   Text = "",
					--   Method = "m",
					--   Function = "",
					--   Constructor = "",
					--   Field = "",
					--   Variable = "",
					--   Class = "",
					--   Interface = "",
					--   Module = "",
					--   Property = "",
					--   Unit = "",
					--   Value = "",
					--   Enum = "",
					--   Keyword = "",
					--   Snippet = "",
					--   Color = "",
					--   File = "",
					--   Reference = "",
					--   Folder = "",
					--   EnumMember = "",
					--   Constant = "",
					--   Struct = "",
					--   Event = "",
					--   Operator = "",
					--   TypeParameter = "",
					-- },
					-- }),
				},
				-- Completion window formatting
				window = {
					-- completion = cmp.config.window.bordered(),
					documentation = {
						border = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" },
					},
				},
				-- Keymappings
				mapping = cmp.mapping.preset.insert({
					["<C-b>"] = cmp.mapping.scroll_docs(-4),
					["<C-f>"] = cmp.mapping.scroll_docs(4),
					["<C-Space>"] = cmp.mapping.complete(),
					["<C-e>"] = cmp.mapping.abort(),
					["<CR>"] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
					["<Tab>"] = cmp.mapping(function(fallback)
						if cmp.visible() then
							cmp.select_next_item()
						elseif luasnip.expand_or_locally_jumpable() then
							luasnip.expand_or_jump()
						else
							fallback()
						end
					end, { "i", "s" }),
					["<S-Tab>"] = cmp.mapping(function(fallback)
						if cmp.visible() then
							cmp.select_prev_item()
						elseif luasnip.locally_jumpable(-1) then
							luasnip.jump(-1)
						else
							fallback()
						end
					end, { "i", "s" }),
				}),
				-- Sources for completion
				sources = cmp.config.sources({
					{ name = "nvim_lsp" },
					{ name = "luasnip" }, -- For luasnip users.
				}, {
					{ name = "buffer" },
				}),
			})
		end,
	},
}
