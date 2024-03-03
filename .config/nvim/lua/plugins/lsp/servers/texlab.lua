local ft = { "tex" }
return {
	{
		"neovim/nvim-lspconfig",
		ft = "tex",
		opts = {
			servers = {
				texlab = {
					ft = ft,
					settings = {},
				},
			},
		},
	},
}
