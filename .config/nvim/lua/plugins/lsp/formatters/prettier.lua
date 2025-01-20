return {
	"stevearc/conform.nvim",
	opts = {
		prettier = {
			config_command = "--config",
			config_names = {
				".prettierrc",
				".prettierrc.json",
				".prettierrc.yml",
				".prettierrc.yaml",
				".prettierrc.json5",
				".prettierrc.js",
				".editorconfig",
			},
			config_path = ".prettierrc.json",
			continuous_string = false,
		},
	},
}
