return {
  "nvimtools/none-ls.nvim",
  dependencies = {
    'nvim-lua/plenary.nvim'
  },
  -- Adding config LSP linters/formatters etc.
  config = function()
    local null_ls = require("null-ls")
    null_ls.setup({
      -- debug = true,
      sources = {

        -- Lua
        null_ls.builtins.formatting.stylua,
        -- null_ls.builtins.diagnostics.luacheck, -- Broken installation with Mason

        -- Cpp
        -- null_ls.builtins.diagnostics.cppcheck, -- not exist in BUILTINS.md
        null_ls.builtins.diagnostics.cmake_lint,
        -- null_ls.builtins.diagnostics.cpplint,
        -- null_ls.builtins.formatting.uncrustify, -- To be tested
        null_ls.builtins.formatting.clang_format, -- To be tested

        -- Python
        -- null_ls.builtins.diagnostics.pylint,
        -- null_ls.builtins.diagnostics.flake8,
        null_ls.builtins.formatting.black, -- Python Formatting

        -- Other
        null_ls.builtins.formatting.prettier, -- Formatting
        -- null_ls.builtins.formatting.isort, -- Sort imports
        null_ls.builtins.formatting.biome, -- JSON formatting
      },
    })

  end,
}
