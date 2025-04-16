-- https://github.com/arduino/arduino-language-server/issues/187
-- TOOD: Fix once arduinolsp works with newest nvim version
local ft = { "arduino" }
return {
	{
		"neovim/nvim-lspconfig",
		ft = ft,
		opts = {
			servers = {
				arduino_language_server = {
					ft = ft,
					settings = {
						arduino_language_server = {
							log = {
								verbosity = "debug",
							},
						},
					},
					cmd = {
						"arduino-language-server",
						"-clangd",
						os.getenv("HOME") .. "/.local/share/nvim/mason/bin/clangd",
						"-cli",
						"/sbin/arduino-cli",
						"-cli-config",
						os.getenv("HOME") .. "/.arduino15/arduino-cli.yaml",
					},
					use_default = false,
				},
			},
		},
	},
}
