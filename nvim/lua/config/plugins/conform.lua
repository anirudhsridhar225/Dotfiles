return {
  'stevearc/conform.nvim',
  opts = {},
  config = function()
	  require("conform").setup({
		format_on_save = {
			timeout_ms = 400,
			lsp_format = "fallback",
		},
		formatter_by_ft = {
			lua = { "stylua" },
			python = { "ruff" },
			rust = { "rustfmt", lsp_format = "fallback" },
			javascript = { "prettier", "prettierd" },
		},
	  })
	end,
}
