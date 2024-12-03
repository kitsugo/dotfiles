-- Treesitter configuration
return {
	"nvim-treesitter/nvim-treesitter",
	dependencies = {
		{ "neovim/nvim-lspconfig" },
	},
	ft = {
		"astro",
		"bash",
		"html",
		"markdown",
		"lua",
		"scala",
		"java",
		"javascript",
		"python",
		"typescript",
		"typescriptreact",
	},
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
