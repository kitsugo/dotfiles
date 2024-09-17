local ft = { "javascript", "typescript", "typescriptreact" }
return {
	{
		"neovim/nvim-lspconfig",
		ft = ft,
		opts = {
			servers = {
				ts_ls = {
					ft = ft,
					settings = {},
				},
			},
		},
	},
}
