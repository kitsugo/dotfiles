return {
	"nvim-telescope/telescope.nvim",
	dependencies = {
		{ "nvim-lua/plenary.nvim" },
	},
	keys = {
		{ "<leader>//", ":Telescope find_files<CR>" },
		{ "<leader>/b", ":Telescope buffers<CR>" },
		{ "<leader>/h", ":Telescope help_tags<CR>" },
	},
}
