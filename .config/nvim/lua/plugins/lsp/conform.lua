local configs_location = vim.fn.stdpath("config") .. "/configs/"
local utils = require("utils")

-- Formatter manager
-- Formatting is deferred until formatting operation takes place once manually. Formatting is then also done on save.
-- All formatters are setup regardless of open filetype but only start when ued within the respective filetype "formatters_by_ft"
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
		for formatter, formatter_settings in pairs(opts) do
			opts[formatter] = {
				prepend_args = function(_, ctx)
					if utils.has_local_config(ctx.filename, formatter_settings.config_names) then
						return {}
					else
						return {
							formatter_settings.config_command,
							configs_location .. formatter_settings.config_path,
						}
					end
				end,
			}
		end
		require("conform").setup({
			log_level = vim.log.levels.DEBUG,
			formatters_by_ft = {
				lua = { "stylua" },
				javascript = { { "prettier" } },
				markdown = { { "prettier" } },
				html = { { "prettier" } },
				css = { { "prettier" } },
			},
			formatters = opts,
		})
	end,
}
