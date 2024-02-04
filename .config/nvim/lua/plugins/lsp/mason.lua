-- Language server + Mason setup
local M = {
	"williamboman/mason.nvim",
	dependencies = {
		{ "williamboman/mason-lspconfig.nvim" },
		{ "neovim/nvim-lspconfig" },
	},
}

function M.config()
	local lspconfig = require("lspconfig")
	require("mason").setup({
		ui = {
			border = "double",
			icons = {
				package_installed = "✓",
				package_pending = "➜",
				package_uninstalled = "✗",
			},
		},
	})
	require("mason-lspconfig").setup({
		ensure_installed = LANGUAGES.servers,
	})

	-- Setup LSP and apply settings of each language server
	local handlers = require("handlers")
	handlers.setup()
	local opts = {}
	for _, server in pairs(LANGUAGES.servers) do
		opts = {
			on_attach = handlers.on_attach,
			capabilities = handlers.capabilities,
		}
		local status_settings, conf_opts = pcall(require, "plugins.lsp.settings." .. server)
		if status_settings then
			opts = vim.tbl_deep_extend("force", conf_opts, opts)
		end
		-- print(server)
		lspconfig[server].setup(opts)
	end
end

return M
