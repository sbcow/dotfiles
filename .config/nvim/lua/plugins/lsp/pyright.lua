local util = require 'lspconfig.util'

local root_files = {
  'pyproject.toml',
  'setup.py',
  'setup.cfg',
  'requirements.txt',
  'Pipfile',
  'pyrightconfig.json',
  '.git',
}

local function organize_imports()
  local params = {
    command = 'pyright.organizeimports',
    arguments = { vim.uri_from_bufnr(0) },
  }

  local clients = vim.lsp.get_active_clients {
    bufnr = vim.api.nvim_get_current_buf(),
    name = 'pyright',
  }
  for _, client in ipairs(clients) do
    client.request('workspace/executeCommand', params, nil, 0)
  end
end

-- local function set_python_path(path)
--   local clients = vim.lsp.get_active_clients {
--     bufnr = vim.api.nvim_get_current_buf(),
--     name = 'pyright',
--   }
--   for _, client in ipairs(clients) do
--     if client.settings then
--       client.settings.python = vim.tbl_deep_extend('force', client.settings.python, { pythonPath = path })
--     else
--       client.config.settings = vim.tbl_deep_extend('force', client.config.settings, { python = { pythonPath = path } })
--     end
--     client.notify('workspace/didChangeConfiguration', { settings = nil })
--   end
-- end
local function set_python_path(path)
  local clients = vim.lsp.get_active_clients({
    bufnr = vim.api.nvim_get_current_buf(),
    name = 'pyright',
  })

  for _, client in ipairs(clients) do
    if client.config.settings then
      client.config.settings.python.pythonPath = path
    else
      client.config.settings = { python = { pythonPath = path } }
    end
    client.notify('workspace/didChangeConfiguration', { settings = client.config.settings })
  end
end

local function append_python_path(new_path)
  local clients = vim.lsp.get_active_clients({
    bufnr = vim.api.nvim_get_current_buf(),
    name = 'pyright',
  })

  for _, client in ipairs(clients) do
    -- Retrieve the current PYTHONPATH from the client settings
    local current_path = client.config.settings.python and client.config.settings.python.pythonPath or ""
    
    -- Append the new path to the current PYTHONPATH
    local updated_path
    if current_path ~= "" then
      updated_path = current_path .. ":" .. new_path
    else
      updated_path = new_path
    end

    -- Update the client settings with the new PYTHONPATH
    if client.config.settings then
      client.config.settings.python.pythonPath = updated_path
    else
      client.config.settings = { python = { pythonPath = updated_path } }
    end

    -- Notify the LSP server of the configuration change
    client.notify('workspace/didChangeConfiguration', { settings = client.config.settings })
  end
end

return {
  default_config = {
    cmd = { 'pyright-langserver', '--stdio' },
    filetypes = { 'python' },
    -- root_dir = function(fname)
    --   return util.root_pattern(unpack(root_files))(fname)
    -- end,
    root_dir = function(fname)
      -- Look for a directory containing one of the root files
      return vim.fs.dirname(vim.fs.find(root_files, {path = vim.fs.dirname(fname), upward = true })[1])
    end,
    single_file_support = true,
    settings = {
      python = {
        analysis = {
          autoSearchPaths = true,
          useLibraryCodeForTypes = true,
          diagnosticMode = 'openFilesOnly',
        },
      },
    },
  },
  commands = {
    PyrightOrganizeImports = {
      organize_imports,
      description = 'Organize Imports',
    },
    PyrightSetPythonPath = {
      set_python_path,
      description = 'Reconfigure pyright with the provided python path',
      nargs = 1,
      complete = 'file',
    },
    PyrightAppendPythonPath = {
      append_python_path,
      description = 'Reconfigure pyright by appending the provided python path',
      nargs = 1,
      complete = 'file',
    },
  },
  docs = {
    description = [[
https://github.com/microsoft/pyright

`pyright`, a static type checker and language server for python
]],
  },
}

