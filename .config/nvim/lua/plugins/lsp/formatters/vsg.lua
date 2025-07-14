return {
	"stevearc/conform.nvim",
	opts = {
		vsg = {
			config_command = "-c",
			config_names = {},
			config_path = ".vhdl_rules.json",
			additional_args = { "--style", "jcl"},
			continuous_string = false,
		},
	},
}
