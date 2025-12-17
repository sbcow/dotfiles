return {
	"obsidian-nvim/obsidian.nvim",
	dependencies = {
		"hrsh7th/nvim-cmp",
    "nvim-telescope/telescope.nvim",
    "nvim-treesitter/nvim-treesitter",
    "OXY2DEV/markview.nvim",
  },
	version = "*", -- recommended, use latest release instead of latest commit
	-- ft = "markdown",
  -- Replace the above line with this if you only want to load obsidian.nvim for markdown files in your vault:
	event = {
	  -- If you want to use the home shortcut '~' here you need to call 'vim.fn.expand'.
	  -- E.g. "BufReadPre " .. vim.fn.expand "~" .. "/my-vault/*.md"
	  -- refer to `:h file-pattern` for more examples
    "BufReadPre " .. vim.fn.expand "~" .. "/Documents/Obsidian Vault/*.md",
    "BufNewFile " .. vim.fn.expand "~" .. "/Documents/Obsidian Vault/*.md"
	},
	---@module 'obsidian'
	---@type obsidian.config
	opts = {
    legacy_commands = false,
		workspaces = {
			{
				name = "work",
        path = vim.fn.expand("/Users/sean/Library/Mobile Documents/iCloud~md~obsidian/Documents/Brain"),
				-- path = "/Users/sean.cowan/Documents/Obsidian Vault",
			},
		},

		-- see below for full list of options 👇
	},

  config = function()
    local obsidian = require("obsidian")
    obsidian.setup({
      log_level = vim.log.levels.INFO
    })
  end,
    -- vim.api.nvim_create_autocmd("FileType", {
    --   pattern = "markdown",
    --   callback = function()
    --     vim.opt_local.textwidth = 100  -- set your preferred line length here
    --     vim.opt_local.formatoptions = vim.opt_local.formatoptions + "t"  -- enable auto-wrap on textwidth
    --   end,
    -- })
}
