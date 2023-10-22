local M = {
	"akinsho/bufferline.nvim",
	dependencies = {
		{ "nvim-tree/nvim-web-devicons" },
	},
}

function M.config()
	require("bufferline").setup({
		options = {
			offsets = { {
				filetype = "NvimTree",
				text = " ",
				separator = true,
			} },
			diagnostics = "nvim_lsp",
			diagnostics_indicator = function(count, level, diagnostics_dict, context)
				local icon = level:match("error") and " " or " "
				return " " .. icon .. count
			end,
		},
	})
end

return M
