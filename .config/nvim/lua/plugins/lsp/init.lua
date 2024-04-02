-- LSP Manager
-- LSP setup is deferred until any filetype is entered with available LSP.
-- A server attaches automatically for its respective filetypes
return {
	{
		import = "plugins.lsp",
	},
	{
		"neovim/nvim-lspconfig",
		import = "plugins.lsp.servers",
		dependencies = {
			{ "williamboman/mason-lspconfig.nvim" },
			{ "hrsh7th/cmp-nvim-lsp" },
		},
		ft = { "java", "scala" },
		opts = {
			diagnostics = {
				underline = true,
				update_in_insert = false,
				virtual_text = false,
				severity_sort = true,
				signs = {
					{ name = "DiagnosticSignError", text = "" },
					{ name = "DiagnosticSignWarn", text = "" },
					{ name = "DiagnosticSignHint", text = "" },
					{ name = "DiagnosticSignInfo", text = "" },
				},
			},
		},
		config = function(l, opts)
			local lspconfig = require("lspconfig")
			require("mason-lspconfig").setup()

			-- Capabilities
			local cmp_status, cmp_lsp = pcall(require, "cmp_nvim_lsp")
			local global_capabilities = vim.tbl_deep_extend(
				"force",
				{},
				vim.lsp.protocol.make_client_capabilities(),
				cmp_status and cmp_lsp.default_capabilities() or {}
			)

			-- Diagnostics
			for _, sign in ipairs(opts.diagnostics.signs) do
				vim.fn.sign_define(sign.name, { texthl = sign.name, text = sign.text, numhl = "" })
			end
			vim.diagnostic.config(opts.diagnostics)

			-- Setup all defined servers
			for server, server_config in pairs(opts.servers) do
				local options = {
					capabilities = vim.tbl_deep_extend("force", global_capabilities, server_config.capabilities or {}),
					on_attach = server_config.on_attach,
					settings = server_config.settings,
					autostart = server_config.autostart,
				}
				lspconfig[server].setup(options)
			end
		end,
	},
	{
		"williamboman/mason.nvim",
		cmd = "Mason",
		config = function()
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
		end,
	},
}
