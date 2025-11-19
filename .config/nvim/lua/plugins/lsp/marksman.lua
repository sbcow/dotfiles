local util = require("lspconfig.util")

return {
  cmd = { "marksman", "server" },
  filetypes = { "markdown" },
  root_dir = util.root_pattern(".git", "README.md"),  -- or your root markers
}
