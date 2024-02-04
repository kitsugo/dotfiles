-- Setup to have default source configurations which will be overwritten by local configuration files
-- @config_command: The CLI option to pass a config file with
-- @config_names: All names the config file could have in a local setting (does not take into account inline options!)
-- @config_path: The name of the default config located in nvim/configs/
return {
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
	},
	eslint_d = {
		config_command = "--config",
		config_names = { ".eslintrc.json" },
		config_path = ".eslintrc.json",
	},
}
