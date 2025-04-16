return {
	"stevearc/conform.nvim",
	opts = {
		clang_format = {
			config_command = "--style=file:",
			config_names = {
				".clang-format",
			},
			config_path = ".clang-format",
			continuous_string = true,
		},
	},
}
