local ft = { "go" }
return {
	{
		"neovim/nvim-lspconfig",
		ft = ft,
		opts = {
			servers = {
				gopls = {
					ft = ft,
					settings = {},
				},
			},
		},
	},
}
