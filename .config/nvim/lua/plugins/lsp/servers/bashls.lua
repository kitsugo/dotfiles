local ft = { "sh" }
return {
	{
		"neovim/nvim-lspconfig",
		ft = ft,
		opts = {
			servers = {
				bashls = {
					ft = ft,
					settings = {
						bashIde = {
							shellcheckArguments = "--rcfile="
								.. vim.fn.stdpath("config")
								.. "/configs/shellcheckrc.conf",
						},
					},
				},
			},
		},
	},
}
