return {
	"lervag/vimtex",
	event = { "BufReadPre", "BufNewFile" },
  init = function()
    vim.g.vimtex_view_method = "skim"
    vim.g.vimtex_view_general_viewer = "skim"
    vim.g.vimtex_view_forward_search_on_start = false
    vim.g.vimtex_compiler_method = 'latexmk'
    vim.g.vimtex_mappings_prefix = 't'
    -- vim.g.vimtex_quickfix_enabled= 1
    vim.g.vimtex_quickfix_mode=0
    vim.g.tex_comment_nospell = 1 -- Ignore spelling mistakes
  end
}

