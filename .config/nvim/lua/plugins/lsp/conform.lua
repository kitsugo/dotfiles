local configs_location = vim.fn.stdpath("config") .. "/configs/"
local utils = require("utils")

local function get_formatter_config_arg(file_name, formatter_settings)
	if utils.has_local_config(file_name, formatter_settings.config_names) then
		return {}
	else
		if formatter_settings.continuous_string then
			return {
				formatter_settings.config_command .. configs_location .. formatter_settings.config_path,
			}
		else
			return {
				formatter_settings.config_command,
				configs_location .. formatter_settings.config_path,
			}
		end
	end
end

-- Formatter manager
-- Formatting is deferred until formatting operation takes place once manually.
-- All formatters are setup regardless of open filetype but only start when used within the respective filetype "formatters_by_ft"
-- Formatters can be set explicitly in their respective ./formatters/*.lua file to allow default configuration handling
return {
	"stevearc/conform.nvim",
	import = "plugins.lsp.formatters",
	keys = {
		{
			"<leader>lf",
			function()
				require("conform").format({ async = true, lsp_fallback = true })
			end,
		},
	},
	config = function(_, opts)
		local formatters = {}
		for formatter, formatter_settings in pairs(opts) do
			formatter = formatter:gsub("_", "-")
			local prepend_args_table = {
				prepend_args = function(_, ctx)
					local formatter_config_arg = get_formatter_config_arg(ctx.filename, formatter_settings)
					if formatter_settings.config ~= nil then
						return utils.append_inplace(formatter_config_arg, formatter_settings.config.prepend_args or {})
					else
						return formatter_config_arg
					end
				end,
			}

			formatters[formatter] = vim.tbl_deep_extend("keep", prepend_args_table, formatter_settings.config or {})
		end
		require("conform").setup({
			log_level = vim.log.levels.TRACE,
			formatters_by_ft = {
				arduino = { "clang-format" },
				c = { "clang-format" },
				cpp = { "clang-format" },
				css = { "prettier" },
				html = { "prettier" },
				javascript = { "prettier" },
				json = { "prettier" },
				jsonc = { "prettier" },
				lua = { "stylua" },
				markdown = { "prettier" },
				rust = { "rustfmt" },
				sh = { "shfmt" },
				tex = { "latexindent" },
				typescript = { "prettier" },
				typescriptreact = { "prettier" },
				vhdl = { "vsg" },
				yaml = { "prettier" },
				xml = { "xmlformatter" },
			},
			formatters = formatters,
		})
	end,
}
