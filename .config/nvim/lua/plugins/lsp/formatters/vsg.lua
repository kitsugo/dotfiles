return {
	"stevearc/conform.nvim",
	opts = {
		vsg = {
			config_command = "-c",
			config_names = {},
			config_path = "vhdl_rules.yaml",
			continuous_string = false,
			config = {
				prepend_args = { "--style", "jcl" },
			},
		},
	},
}
