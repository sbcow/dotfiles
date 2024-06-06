  return {
    {
      "nvim-treesitter/nvim-treesitter",
      build = ":TSUpdate",
      config = function()
        local config = require("nvim-treesitter.configs")
        config.setup({
          ensure_installed = {"lua", "javascript", "c", "cpp", "python", "json", "rust", "vim", "vimdoc", "query", "latex"}, -- 
          highlight = {
            enable = true,
            -- disable = {"c", "rust"}, -- For a specified list of languages to ignore
            disable = function(lang, buf) -- For a function that disables treesitter for large files (slowing it down)
                local max_filesize = 100 * 1024 -- 100 KB
                local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
                if ok and stats and stats.size > max_filesize then
                    return true
                end
            end,
          },
          indent = { enable = true },
          auto_install = true,
          sync_install = false,
        })
      end,

    },
    -- To see the current function context at all times
    {
      "nvim-treesitter/nvim-treesitter-context",
      config = function()
        local config = require("treesitter-context")
        config.setup({
          enable = true, -- Enable this plugin (Can be enabled/disabled later via commands)
          max_lines = 0, -- How many lines the window should span. Values <= 0 mean no limit.
          min_window_height = 0, -- Minimum editor window height to enable context. Values <= 0 mean no limit.
          line_numbers = true,
          multiline_threshold = 5, -- Maximum number of lines to show for a single context
          trim_scope = 'outer', -- Which context lines to discard if `max_lines` is exceeded. Choices: 'inner', 'outer'
          mode = 'cursor',  -- Line used to calculate context. Choices: 'cursor', 'topline'
          -- Separator between context and content. Should be a single character string, like '-'.
          -- When separator is set, the context will only show up when there are at least 2 lines above cursorline.
          separator = '-',
          zindex = 20, -- The Z-index of the context window
          on_attach = nil, -- (fun(buf: integer): boolean) return false to disable attaching
        })
      end
    }
  }

