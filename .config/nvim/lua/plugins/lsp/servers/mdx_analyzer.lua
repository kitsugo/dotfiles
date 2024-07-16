local ft = { "markdown.mdx" }
return {
	{
		"neovim/nvim-lspconfig",
		ft = ft,
		opts = {
			servers = {
				mdx_analyzer = {
					ft = ft,
					settings = {},
				},
			},
		},
	},
}
