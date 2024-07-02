local ft = { "rust" }
return {
	{
		"neovim/nvim-lspconfig",
		ft = ft,
		opts = {
			servers = {
				rust_analyzer = {
					ft = ft,
					settings = {
						cargo = {
							allFeatures = true,
						},
					},
				},
			},
		},
	},
}
