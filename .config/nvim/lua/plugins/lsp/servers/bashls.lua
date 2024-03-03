local ft = { "sh" }
return {
	{
		"neovim/nvim-lspconfig",
		ft = ft,
		opts = {
			servers = {
				bashls = {
					ft = ft,
					settings = {}
				},
			},
		},
	},
}
