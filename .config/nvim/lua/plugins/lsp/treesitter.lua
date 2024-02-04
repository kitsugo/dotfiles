-- Treesitter configuration
local M = {
	"nvim-treesitter/nvim-treesitter",
}

function M.config()
	require("nvim-treesitter.configs").setup({
		ensure_installed = LANGUAGES.treesitter,
		sync_install = false,
		auto_install = false,
		highlight = {
			enable = true,
		},
		indent = {
			enable = true,
		},
	})
end

return M
