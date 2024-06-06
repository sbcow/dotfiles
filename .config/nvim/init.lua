-- TODO: Add telescop to look in various files

-------------------------
-- Options --------------
-------------------------

vim.cmd([[autocmd FileType * set formatoptions-=ro]]) -- Turn of auto comments

vim.g.mapleader = " "
vim.g.maplocalleader = " "

local options = {
  clipboard = "unnamedplus",               -- allows neovim to access the system clipboard
  cmdheight = 1,                           -- more space in the neovim command line for displaying messages
  completeopt = {"menu", "menuone", "noselect"}, -- mostly just for cmp
  conceallevel = 0,                        -- so that `` is visible in markdown files
  fileencoding = "utf-8",                  -- the encoding written to a file
  hlsearch = true,                         -- highlight all matches on previous search pattern
  ignorecase = true,                       -- ignore case in search patterns
  mouse = "",                             -- allow the mouse to be used in neovim
  pumheight = 10,                          -- pop up menu height
  showmode = false,                        -- we don't need to see things like -- INSERT -- anymore
  showtabline = 2,                         -- always show tabs
  smartcase = true,                        -- smart case
  smartindent = true,                      -- make indenting smarter again
  lazyredraw = true,
  splitbelow = true,                       -- force all horizontal splits to go below current window
  splitright = true,                       -- force all vertical splits to go to the right of current window
  termguicolors = true,                    -- set term gui colors (most terminals support this)
  timeoutlen = 1000,                       -- time to wait for a mapped sequence to complete (in milliseconds)
  ttimeoutlen = 50,                       -- time to wait for a mapped sequence to complete (in milliseconds)
  updatetime = 50,                       -- faster completion (4000ms default)
  expandtab = true,                        -- convert tabs to spaces
  shiftwidth = 2,                          -- the number of spaces inserted for each indentation
  tabstop = 2,                             -- insert 2 spaces for a tab
  --  cursorline = true,                       -- highlight the current line
  number = true,                           -- set numbered lines
  laststatus = 3,
  errorbells = false,
  confirm = true,
  showcmd = true,
  ruler = false,
  relativenumber = true,                   -- set relative numbered lines
  numberwidth = 4,                         -- set number column width to 2 {default 4}
  signcolumn = "yes",                      -- always show the sign column, otherwise it would shift the text each time
  wrap = false,                            -- display lines as one long line
  scrolloff = 8,                           -- is one of my fav
  sidescrolloff = 8,
  -- guifont = "monospace:h17",               -- the font used in graphical neovim applications
  guicursor = 'n-v-c:block,i:ver51,a:blinkwait250-blinkoff250-blinkon250',
  textwidth = 100,

  -- swap/backup/undo
  swapfile = false,
  backup = false,
  undodir = os.getenv("HOME") .. "/.vim/undodir",
  undofile = true,

} -- end options

for k, v in pairs(options) do
  vim.opt[k] = v
end

--------------------------------
-- Lazy (Package manager) ------
--------------------------------

-- Checks if lazy exists in a path, otherwise clone it
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- Setup of lazy

require("lazy").setup("plugins") -- specifies the plugins.lua file, can also be directory with all files in separate .lua files


--------------------------
-- Cattpuccin setup ------
--------------------------

require("catppuccin").setup()

--------------------------
-- Telescope setup -------
--------------------------

local telescope_builtin = require("telescope.builtin")

vim.keymap.set('n', '<leader>ff', telescope_builtin.find_files, {})
vim.keymap.set('n', '<leader>ft', telescope_builtin.live_grep, {})
vim.keymap.set('n', '<leader>fg', telescope_builtin.git_files, {})
vim.keymap.set('n', '<leader>fb', telescope_builtin.buffers, {})

-------------------------
-- Neotree --------------
-------------------------

require('neo-tree').setup({
  filesystem = {
    window = {
      mappings = {
        ["P"] = { "toggle_preview", config = { use_float = false, use_image_nvim = true } },
        ["l"] = "open",
        ["h"] = "close_node",
        ["s"] = "open_split",
        ["v"] = "open_vsplit",
        ["K"] = "focus_preview",
        ["<c-p>"] = "navigate_up",
        ["<c-n>"] = "set_root",
      }
    }
  },
  git_status = {
    window = {
      mappings = {
        ["P"] = { "toggle_preview", config = { use_float = false, use_image_nvim = true } },
        ["l"] = "open",
        ["h"] = "close_node",
        ["s"] = "open_split",
        ["v"] = "open_vsplit",
        ["K"] = "focus_preview",
      }
    }
  }

})

-------------------------
-- Lualine --------------
-------------------------

require('lualine').setup()

-------------------------
-- Comment --------------
-------------------------

require('Comment').setup()

-------------------------
-- Keymaps --------------
-------------------------

-- Modes
--   normal_mode = "n",
--   insert_mode = "i",
--   visual_mode = "v",
--   visual_block_mode = "x",
--   term_mode = "t",
--   command_mode = "c",

local opts = { noremap = true, silent = true }

-- Visual mode bindings
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gvi", opts)
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gvi", opts)

-- Primeagen video no.1
vim.keymap.set("i", "<C-j>", "<esc>:m .+1<CR>==", opts)
vim.keymap.set("i", "<C-k>", "<esc>:m .-2<CR>==", opts)

-- Quick buffer switch
vim.keymap.set("n", "<leader>bp", ":bprevious<cr>", opts)
vim.keymap.set("n", "<leader>bn", ":bnext<cr>", opts)

-- Resize with arrows
vim.keymap.set("n", "<leader><Up>", ":resize -20<CR>", opts)
vim.keymap.set("n", "<leader><Down>", ":resize +20<CR>", opts)
vim.keymap.set("n", "<leader><Left>", ":vertical resize -20<CR>", opts)
vim.keymap.set("n", "<leader><Right>", ":vertical resize +20<CR>", opts)

-- End of line
vim.keymap.set("v", "H", "^", opts)
vim.keymap.set("v", "L", "$", opts)
vim.keymap.set("n", "yH", "y^", opts)
vim.keymap.set("n", "yL", "y$", opts)
vim.keymap.set("n", "dH", "d^", opts)
vim.keymap.set("n", "dL", "d$", opts)
vim.keymap.set("n", "H", "^", opts)
vim.keymap.set("n", "L", "$", opts)

-- General/Random <leader> bindings
vim.keymap.set("n", "<leader>h", ":noh<CR>", opts)

-- Keep cursor centered when next/previous
vim.keymap.set("n", "n", "nzzzv", opts)
vim.keymap.set("n", "N", "Nzzzv", opts)

-- Neotree 
vim.keymap.set("n", "<leader>eE", ":Neotree toggle action=focus position=left reveal_force_cwd<CR>", opts)
vim.keymap.set("n", "<leader>ee", ":Neotree toggle action=focus dir=%:p:h:h position=left reveal_force_cwd<CR>", opts)
vim.keymap.set("n", "<leader>el", ":Neotree toggle action=focus source=filesystem position=left<CR>", opts)
vim.keymap.set("n", "<leader>er", ":Neotree toggle action=focus source=filesystem position=right<CR>", opts)
vim.keymap.set("n", "<leader>ef", ":Neotree toggle action=focus source=filesystem position=float<CR>", opts)
vim.keymap.set("n", "<leader>eg", ":Neotree toggle action=focus source=git_status position=float<CR>", opts)

-- Tmux navigation
vim.keymap.set("n", "<C-h>", ":NvimTmuxNavigateLeft<CR>", opts)
vim.keymap.set("n", "<C-j>", ":NvimTmuxNavigateDown<CR>", opts)
vim.keymap.set("n", "<C-k>", ":NvimTmuxNavigateUp<CR>", opts)
vim.keymap.set("n", "<C-l>", ":NvimTmuxNavigateRight<CR>", opts)

-- vim.keymap.set("n", "<leader>th", "<cmd>lua _HTOP_TOGGLE()<cr>", { desc = "Htop" })
-- vim.keymap.set("n", "<leader>tp", "<cmd>lua _PYTHON_TOGGLE()<cr>", { desc = "Python" })
vim.keymap.set("n", "<leader>tf", "<cmd>ToggleTerm direction=float<cr>", { desc = "Float" })
vim.keymap.set("n", "<leader>ts", "<cmd>ToggleTerm size=30 direction=horizontal<cr>", { desc = "Horizontal" })
vim.keymap.set("n", "<leader>tv", "<cmd>ToggleTerm size=100 direction=vertical<cr>", { desc = "Vertical" })

-- Better terminal navigation
vim.keymap.set("t", "<C-h>", "<C-\\><C-N><C-w>h", opts)
vim.keymap.set("t", "<C-j>", "<C-\\><C-N><C-w>j", opts)
vim.keymap.set("t", "<C-k>", "<C-\\><C-N><C-w>k", opts)
vim.keymap.set("t", "<C-l>", "<C-\\><C-N><C-w>l", opts)
vim.keymap.set("t", "<C-[>", "<C-\\><C-N><C-[>", opts)
-- Keymap graveyard
-- vim.keymap.set("n", "<leader>vr", ":source $MYVIMRC<CR>", opts)
-- vim.keymap.set("n", "<leader>]", ":cnext <CR>", opts)
-- vim.keymap.set("n", "<leader>[", ":cprevious <CR>", opts)
-- vim.keymap.set("n", "HH", "0", opts)
-- vim.keymap.set("n", "<C-h>", "<C-W>h", opts)
-- vim.keymap.set("n", "<C-j>", "<C-W>j", opts)
-- vim.keymap.set("n", "<C-k>", "<C-W>k", opts)
-- vim.keymap.set("n", "<C-l>", "<C-W>l", opts)

-- Misc commands
vim.keymap.set("n", "<leader>dt", "<cmd>DiagnosticToggle<cr>", opts)
vim.keymap.set("n", "<leader>vc", "<cmd>VimtexCompile<cr>", opts)
vim.keymap.set("n", "<leader>vx", "<cmd>VimtexStop<cr>", opts)
vim.keymap.set("n", "<leader>ve", "<cmd>VimtexErrors<cr>", opts)
vim.keymap.set("n", "<leader>{", "{V}gq", opts)

-- Keymaps
-- vim.keymap.set("n", "<leader>gf", "<cmd>lua vim.lsp.buf.format()<cr>", {})
vim.keymap.set("n", "<leader>gf", vim.lsp.buf.format, {})



-- Set git editor to open neovim without nesting
local executable = function(e)
  return vim.fn.executable(e) > 0
end
if executable('nvr') or vim.fn.has('nvim') then
  vim.env.GIT_EDITOR = 'nvr -cc split --remote-wait +\'set bufhidden=wipe\''
  vim.env.EDITOR = 'nvr -cc split --remote-wait +\'set bufhidden=wipe\''
end

-- Set Latex stuff

vim.g.vimtex_view_method = "skim"
vim.g.vimtex_view_general_viewer = "skim"
vim.g.vimtex_view_forward_search_on_start = false
vim.g.vimtex_compiler_method = 'latexmk'
vim.g.vimtex_mappings_prefix = 't'
-- vim.g.vimtex_quickfix_enabled= 1
vim.g.vimtex_quickfix_mode=0

-- Create command to suppress all diagnostics
vim.api.nvim_create_user_command("DiagnosticToggle", function()
	local config = vim.diagnostic.config
	local vt = config().virtual_text
	config {
		virtual_text = not vt,
		underline = not vt,
		signs = not vt,
	}
end, { desc = "toggle diagnostic" })
