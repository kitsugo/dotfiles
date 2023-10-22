local M = {
	"jose-elias-alvarez/null-ls.nvim",
	dependencies = {
		{ "nvim-lua/plenary.nvim" },
	},
}

function M.config()
	-- Null-LS setup for additional language options (formatting/linting)
	local null_ls = require("null-ls")
	local null_ls_builtins = require("user.lsp.settings.null-ls-builtins")

	local configs_location = vim.fn.stdpath("config") .. "/configs/"
	-- Checks whether a source has a local config file by searching upward from the current buffer
	local function has_local_config(location, config_names)
		local has = false
		for i in pairs(config_names) do
			local found = vim.fs.find(config_names[i], { upward = true, location })
			if not (next(found) == nil) then
				has = true
				break
			end
		end
		return has
	end

	-- Configure all sources specified in server_config.lua
	local installed_sources = {}
	for source_name, source in pairs(LANGUAGES.sources) do
		table.insert(
			installed_sources,
			null_ls.builtins[source.type][source_name].with({
				-- Apply default configs if no local configs can be found.
				extra_args = function(params)
					local options = null_ls_builtins[source_name]
					if options == nil or has_local_config(params.bufname, options.config_names) then
						return {}
					end
					return { options.config_command, configs_location .. options.config_path }
				end,
			})
		)
	end

	null_ls.setup({
		sources = installed_sources,
	})
end

return M
