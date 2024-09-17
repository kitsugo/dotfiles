local ft = { "markdown", "tex", "latex" }
return {
	{
		"neovim/nvim-lspconfig",
		ft = ft,
		opts = {
			servers = {
				ltex = {
					settings = {
						ltex = {
							enabled = false,
						},
					},
				},
			},
		},
	},
}
