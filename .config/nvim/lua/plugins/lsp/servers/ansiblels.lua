local ft = { "yaml.ansible" }
return {
	{
		"neovim/nvim-lspconfig",
		ft = ft,
		opts = {
			servers = {
				ansiblels = {
					ft = ft,
					settings = {
						ansible = {
							validation = {
								enabled = true,
								lint = {
									enabled = false,
								},
							},
						},
					},
				},
			},
		},
	},
}
