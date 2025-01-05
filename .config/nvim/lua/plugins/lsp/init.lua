-- LSP Manager
-- LSP setup is deferred until any filetype is entered with available LSP.
-- A server attaches automatically for its respective filetypes
--
-- Adding a new server? Check `config.md` for the Lua filename:
-- https://github.com/neovim/nvim-lspconfig/blob/master/doc/configs.md
-- Then add it to ./servers/<name from config.md>.lua and define it. Take another server as a template.
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
		-- Languages with dedicated LSP plugin
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
			local file_types = {}

			-- Capabilities definition
			local cmp_status, cmp_lsp = pcall(require, "cmp_nvim_lsp")
			local global_capabilities = vim.tbl_deep_extend(
				"force",
				{},
				vim.lsp.protocol.make_client_capabilities(),
				cmp_status and cmp_lsp.default_capabilities() or {}
			)

			-- Diagnostics definition
			for _, sign in ipairs(opts.diagnostics.signs) do
				vim.fn.sign_define(sign.name, { texthl = sign.name, text = sign.text, numhl = "" })
			end
			vim.diagnostic.config(opts.diagnostics)

			-- Extract all filetypes from the list of servers inside the module "lsp.servers"
			for file_type, _ in pairs(l._.handlers.ft) do
				table.insert(file_types, file_type)
			end

			-- Extra lazy-loaded LSP setup. Only configure / setup the servers which are actually needed by the currently open filetypes.
			vim.api.nvim_create_autocmd({ "FileType" }, {
				pattern = file_types,
				once = true, -- Run only once for every filetype
				callback = function()
					-- Iterate over all available servers and see if they need to be setup
					for server_name, server_config in pairs(opts.servers) do
						-- Check if any given filetype warrants this server to be setup. If so, set it up and remove it from the table to not set it up again
						for _, server_ft in pairs(server_config.ft) do
							if server_ft == vim.bo.filetype then
								-- Prepare server configuration
								local server_options = {
									capabilities = vim.tbl_deep_extend(
										"force",
										global_capabilities,
										server_config.capabilities or {}
									),
									on_attach = server_config.on_attach,
									settings = server_config.settings,
								}
								-- Setup server and start it, then remove it form table
								lspconfig[server_name].setup(server_options)
								vim.cmd("LspStart")
								opts.servers[server_name] = nil
								break
							end
						end
					end
				end,
			})

			-- Load an LSP manually, on-demand. Used for LSPs which are not associated with a filetype (spell checking)
			vim.api.nvim_create_user_command("Lsp", function(cmd_opts)
				local server_name = cmd_opts.args
				local server_config = opts.servers[server_name]
				local server_options = {
					capabilities = vim.tbl_deep_extend("force", global_capabilities, server_config.capabilities or {}),
					on_attach = server_config.on_attach,
					settings = server_config.settings,
				}

				lspconfig[server_name].setup(server_options)
				vim.cmd("LspStart")
				opts.servers[server_name] = nil
			end, { nargs = "?" })
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
