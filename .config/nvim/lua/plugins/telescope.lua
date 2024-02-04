local M = {
	"nvim-telescope/telescope.nvim",
	dependencies = {
		{ "nvim-lua/plenary.nvim" },
	},
}

function M.config()
	vim.keymap.set("n", "<leader>//", ":Telescope find_files<CR>", { silent = true })
	vim.keymap.set("n", "<leader>/b", ":Telescope buffers<CR>", { silent = true })
	vim.keymap.set("n", "<leader>/h", ":Telescope help_tags<CR>", { silent = true })
end

return M
