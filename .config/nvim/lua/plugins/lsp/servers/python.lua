local ft = { "python" }
return {
	{
		"neovim/nvim-lspconfig",
		ft = ft,
		opts = {
			servers = {
				pylsp = {
					ft = ft,
					settings = {
						pylsp = {
							plugins = {
								pycodestyle = {
									ignore = { "E501" },
								},
							},
						},
					},
				},
			},
		},
	},
}
