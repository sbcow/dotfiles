return {
	"nvimtools/none-ls.nvim",
	event = "VeryLazy",
	dependencies = {
		"nvim-lua/plenary.nvim",
	},
	-- Adding config LSP linters/formatters etc.
	config = function()
		local null_ls = require("null-ls")
		null_ls.setup({
			-- debug = true,
			default_timeout = 2000,
			sources = {

				-- Lua
				null_ls.builtins.formatting.stylua,
				-- null_ls.builtins.diagnostics.luacheck, -- Broken installation with Mason

				-- Cpp
				-- null_ls.builtins.diagnostics.cppcheck, -- not exist in BUILTINS.md
				null_ls.builtins.diagnostics.cmake_lint.with({
					command = "cmakelint", -- Correct executable name from Mason
				}), -- null_ls.builtins.diagnostics.cpplint,
				-- null_ls.builtins.formatting.uncrustify, -- To be tested
				null_ls.builtins.formatting.clang_format, -- To be tested

				-- Python
				-- null_ls.builtins.diagnostics.pylint,
				-- null_ls.builtins.diagnostics.flake8,
				null_ls.builtins.formatting.black.with({
					extra_args = { "--line-length", "100", "-t", "py313" },
					filetypes = { "python" },
				}), -- Python Formatting

				-- reStructuredText
				null_ls.builtins.diagnostics.rstcheck,

				-- Other
				null_ls.builtins.formatting.prettier, -- Formatting
				-- null_ls.builtins.formatting.prettierd, -- Formatting
				-- null_ls.builtins.formatting.isort, -- Sort imports
				null_ls.builtins.formatting.biome.with({
					filetypes = { "JSON" },
				}), -- JSON formatting
				-- null_ls.builtins.formatting.markdownlint, -- Markdown linting
				-- null_ls.builtins.diagnostics.markdownlint, -- Markdown linting
				null_ls.builtins.formatting.typstyle, -- Formatting
				-- null_ls.builtins.formatting.lemminx, -- Formatting
			},
		})
	end,
}
