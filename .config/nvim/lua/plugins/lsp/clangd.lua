local util = require("lspconfig.util")

local function switch_source_header(bufnr)
	bufnr = util.validate_bufnr(bufnr)
	local clangd_client = util.get_active_client_by_name(bufnr, "clangd")
	local params = { uri = vim.uri_from_bufnr(bufnr) }
	if clangd_client then
		clangd_client.request("textDocument/switchSourceHeader", params, function(err, result)
			if err then
				error(tostring(err))
			end
			if not result then
				print("Corresponding file cannot be determined")
				return
			end
			vim.api.nvim_command("edit " .. vim.uri_to_fname(result))
		end, bufnr)
	else
		print("method textDocument/switchSourceHeader is not supported by any servers active on the current buffer")
	end
end

local root_files = {
	".git",
	".clangd",
	".clang-tidy",
	".clang-format",
	"compile_commands.json",
	"compile_flags.txt",
	"configure.ac",
	"CMakeLists.txt",
}

return {
	cmd = { "clangd", "--background-index", "--clang-tidy" },
	filetypes = { "c", "cpp", "h", "hpp", "objc", "objcpp", "cuda", "proto" },
	root_markers = root_files,
  -- root_dir = function(fname)
  --   return vim.fs.root(fname, root_files) or vim.fn.getcwd()
  -- end,
	single_file_support = true,
	capabilities = {
		textDocument = { completion = { editsNearCursor = true } },
		offsetEncoding = { "utf-8", "utf-16" },
	},
	commands = {
		ClangdSwitchSourceHeader = {
			function()
				switch_source_header(0)
			end,
			description = "Switch between source/header",
		},
	},
	init_options = {
		clangdFileStatus = true,
		fallbackFlags = { "--std=c++17" },
	},
}
