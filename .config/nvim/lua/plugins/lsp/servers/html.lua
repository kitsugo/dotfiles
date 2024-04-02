local ft = { "html" }
return {
	{
		"neovim/nvim-lspconfig",
		ft = ft,
		opts = {
			servers = {
				html = {
					ft = ft,
					settings = {},
				},
			},
		},
	},
}
