local utils = require("utils")

return {
	"lewis6991/gitsigns.nvim",
	enabled = utils.is_installed("git"),
	lazy = not utils.is_git_project(vim.fn.expand("%:p")),
	config = function()
		require("gitsigns").setup({
			on_attach = function(bufnr)
				local gs = package.loaded.gitsigns
				vim.keymap.set("n", "<leader>gb", function()
					gs.blame_line({ full = true })
				end)
			end,
		})
	end,
}
