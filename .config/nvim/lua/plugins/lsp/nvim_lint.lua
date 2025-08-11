return {
	"mfussenegger/nvim-lint",
	config = function()
		require("lint").linters_by_ft = {
			vhdl = { "vsg" },
		}

		-- require("lint").  = {
		-- 	["error"] = vim.diagnostic.severity.HINT,
		-- 	["warning"] = vim.diagnostic.severity.HINT,
		-- 	["information"] = vim.diagnostic.severity.HINT,
		-- 	["hint"] = vim.diagnostic.severity.HINT,
		-- }

		local original = require("lint").linters.vsg
		require("lint").linters.vsg = function()
			local vsg = original()
			table.insert(vsg.args, "--style")
			table.insert(vsg.args, "jcl")
			table.insert(vsg.args, "-c")
			table.insert(vsg.args, "/home/toffee/.config/nvim/configs/vhdl_rules.yaml")
			return vsg
		end

		local lint = require("lint")
		lint.linters.vsg = require("lint.util").wrap(lint.linters.vsg, function(diagnostic)
			diagnostic.severity = vim.diagnostic.severity.HINT
			return diagnostic
		end)

		vim.api.nvim_create_autocmd({ "BufWritePost" }, {
			callback = function()
				require("lint").try_lint()
			end,
		})
	end,
}
