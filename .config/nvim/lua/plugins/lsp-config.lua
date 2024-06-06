local lsp_servers = { "lua_ls", "clangd", "pyright", "texlab" }

return {
  {
    "williamboman/mason.nvim",
    -- version = "1.10.0",
    config = function()
      require("mason").setup({
        -- ui = {
        --   icons = {
        --     package_installed = "✓",
        --     package_pending = "➜",
        --     package_uninstalled = "✗",
        --   },
        -- },
        pip = {
          upgrade_pip = true,
        },
      })
    end,
  },
  -- mason-lspconfig bridges gap between mason and lsp-config
  {
    "williamboman/mason-lspconfig.nvim",
    config = function()
      require("mason-lspconfig").setup({
        ensure_installed = lsp_servers,
      })
    end,
  },
  -- nvim-lspconfig allows keybinding to setup comms
  {
    "neovim/nvim-lspconfig",
    config = function()
      local capabilities = require("cmp_nvim_lsp").default_capabilities()

      local lspconfig = require("lspconfig")
      -- Add lsp and establish comms between neovim and lsp server
      lspconfig.lua_ls.setup({
        capabilities = capabilities,
      })
      lspconfig.clangd.setup(require("plugins.lsp.clangd"))
      lspconfig.pyright.setup(require("plugins.lsp.pyright"))
      lspconfig.texlab.setup(require("plugins.lsp.texlab"))

      -- Keymaps
      vim.keymap.set("n", "K", vim.lsp.buf.hover, {})
      vim.keymap.set("n", "gd", vim.lsp.buf.definition, {})
      vim.keymap.set("n", "gD", vim.lsp.buf.declaration, {})
      vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, {})
    end,
  },
}
