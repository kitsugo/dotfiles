return {
	"numToStr/Comment.nvim",
	keys = {
		{ "gcc" },
		{ "gc", mode = "v" },
	},
	config = function()
		require("Comment").setup()
	end,
}
