local M = {
	"lewis6991/gitsigns.nvim",
	enabled = check_installed("git"),
}

function M.config()
	require("gitsigns").setup({
		on_attach = function(bufnr)
			local gs = package.loaded.gitsigns

			vim.keymap.set("n", "<leader>gb", function()
				gs.blame_line({ full = true })
			end)
		end,
	})
end

return M
