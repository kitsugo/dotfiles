-- Treesitter configuration
return {
	"nvim-treesitter/nvim-treesitter",
	dependencies = {
		{ "neovim/nvim-lspconfig" },
	},
	ft = { "lua", "bash", "html", "markdown", "scala", "java" },
	config = function()
		require("nvim-treesitter.configs").setup({
			ensure_installed = { "lua" },
			sync_install = false,
			auto_install = false,
			highlight = {
				enable = true,
			},
			indent = {
				enable = true,
			},
		})
	end,
}
