local M = {
	"windwp/nvim-autopairs",
}

function M.config()
	local autopairs = require("nvim-autopairs")
	local rule = require("nvim-autopairs.rule")

	autopairs.setup({
		-- check_ts = true,
	})

	autopairs.add_rules({
		rule("$", "$", { "tex", "latex", "markdown" }),
		rule("\\{", "\\}", { "tex", "latex", "markdown" }),
		rule('"', '"', { "markdown" }),
		rule("{", "}", { "markdown" }),
		rule("(", ")", { "markdown" }),
	})
end

return M
