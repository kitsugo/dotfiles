return {
	"nvim-telescope/telescope.nvim",
	dependencies = {
		{ "nvim-lua/plenary.nvim" },
	},
	keys = {
		{ "<leader>/.", ":Telescope find_files<CR>" },
		{ "<leader>//", ":Telescope live_grep<CR>" },
		{ "<leader>/b", ":Telescope buffers<CR>" },
		{ "<leader>/h", ":Telescope help_tags<CR>" },
	},

	config = function()
		require("telescope").setup({
			defaults = {
				file_ignore_patterns = { ".git/", "node_modules/", ".*.html" },
			},
		})
	end,
}
