return {
	{
		"neovim/nvim-lspconfig",
		ft = "python",
		opts = {
			languages = {
				python = {
					server = "pylsp",
				},
			},
		},
	},
}

