local ft = { "css" }
return {
	{
		"neovim/nvim-lspconfig",
		ft = ft,
		opts = {
			servers = {
				cssls = {
					ft = ft,
					settings = {}
				},
			},
		},
	},
}

