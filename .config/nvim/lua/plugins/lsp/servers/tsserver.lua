local ft = { "javascript", "typescript" }
return {
	{
		"neovim/nvim-lspconfig",
		ft = ft,
		opts = {
			servers = {
				tsserver = {
					ft = ft,
					settings = {},
				},
			},
		},
	},
}
