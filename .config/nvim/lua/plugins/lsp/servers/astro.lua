local ft = { "astro"  }
return {
	{
		"neovim/nvim-lspconfig",
		ft = ft,
		opts = {
			servers = {
				astro = {
					ft = ft,
					settings = {},
				},
			},
		},
	},
}

