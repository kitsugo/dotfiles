return {
	"akinsho/bufferline.nvim",
	dependencies = {
		{ "nvim-tree/nvim-web-devicons" },
	},
	event = "BufAdd",
	config = function()
		require("bufferline").setup({
			options = {
				offsets = { {
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
	end,
}
