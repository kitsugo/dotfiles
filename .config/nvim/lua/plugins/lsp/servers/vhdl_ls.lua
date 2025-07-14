local ft = { "vhd", "vhdl" }
return {
	{
		"neovim/nvim-lspconfig",
		ft = ft,
		opts = {
			servers = {
				vhdl_ls = {
					ft = ft,
					settings = {},
				},
			},
		},
	},
}
