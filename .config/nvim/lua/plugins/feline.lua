local M = {
	"feline-nvim/feline.nvim",
	dependencies = {
		{
			"nvim-tree/nvim-web-devicons",
		},
	},
	lazy = true,
}

function M.config()
	-- TODO: Do something with this
	local feline = require("feline")
	feline.setup({})
end

return M
