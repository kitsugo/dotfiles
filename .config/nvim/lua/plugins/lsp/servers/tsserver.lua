local ft = { "javascript", "typescript", "typescriptreact" }
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
