local lsp_servers = { "lua_ls", "clangd", "pyright", "texlab", "julials", "marksman" }

return {
	{
		"williamboman/mason.nvim",
		event = "VeryLazy",
		config = function()
			require("mason").setup({
				pip = {
					upgrade_pip = true,
				},
			})
		end,
	},

	{
		"williamboman/mason-lspconfig.nvim",
		event = "VeryLazy",
		config = function()
			require("mason-lspconfig").setup({
				ensure_installed = lsp_servers,
			})
		end,
	},

	{
		"neovim/nvim-lspconfig",
		event = "VeryLazy",
		-- config = function()
		--   local capabilities = require("cmp_nvim_lsp").default_capabilities()
		--
		--   -- Define per-server configurations
		--   local servers = {
		--     lua_ls = { capabilities = capabilities },
		--     clangd = require("plugins.lsp.clangd"),
		--     pyright = require("plugins.lsp.pyright"),
		--     texlab = require("plugins.lsp.texlab"),
		--     julials = require("plugins.lsp.julials"),
		--     marksman = require("plugins.lsp.marksman"),
		--   }
		--
		--   -- Attach all defined servers using the new API
		--   for server, config in pairs(servers) do
		--     vim.lsp.start(config, { name = server })
		--   end
		--
		--   -- Keymaps
		-- end,
	},
}
