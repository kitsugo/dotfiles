local ft = { "markdown", "tex" }
return {
	{
		"neovim/nvim-lspconfig",
		ft = ft,
		opts = {
			servers = {
				ltex = {
					settings = {
						ltex = {
							enabled = ft,
						},
					},
				},
			},
		},
	},
}
