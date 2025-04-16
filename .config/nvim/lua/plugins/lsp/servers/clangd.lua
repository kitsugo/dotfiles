-- TODO: Remove arduino once arduinolsp is fixed (no buffer attachment)
local ft = { "c", "cpp", "objc", "objcpp", "cuda", "proto" }
return {
	{
		"neovim/nvim-lspconfig",
		ft = ft,
		opts = {
			servers = {
				clangd = {
					ft = ft,
					settings = {},
					on_new_config = function(config)
						local configs_location = vim.fn.stdpath("config") .. "/configs/"
						config.cmd = { "clangd", "--fallback-style=" .. configs_location .. ".clang-format" }
					end,
				},
			},
		},
	},
}
