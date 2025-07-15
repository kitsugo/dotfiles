-- LSP Manager
-- Server setup is deferred until any filetype is entered with available LSP.
-- Server start is deferred until manual start ('<leader>ll' or 'Lsp <server_name>' custom command)
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
					text = {
						[vim.diagnostic.severity.ERROR] = "",
						[vim.diagnostic.severity.WARN] = "",
						[vim.diagnostic.severity.INFO] = "",
						[vim.diagnostic.severity.HINT] = "",
					},
					linehl = {
						[vim.diagnostic.severity.ERROR] = "ErrorMsg",
					},
					numhl = {
						[vim.diagnostic.severity.WARN] = "WarningMsg",
					},
				},
			},
		},
		keys = {
			{
				"<leader>ll",
				":LspStart<CR>",
			},
		},
		config = function(l, opts)
			-- Load Mason to point to installed servers
			require("mason-lspconfig").setup({
				automatic_enable = false,
			})
			-- Load cmp_lsp for snippets / autocompletion
			local cmp_status, cmp_lsp = pcall(require, "cmp_nvim_lsp")
			-- Global diagnostics configuration
			vim.diagnostic.config(opts.diagnostics)

			-- Extract all filetypes from the list of servers inside the module "lsp.servers"
			local file_types = {}
			for file_type, _ in pairs(l._.handlers.ft) do
				table.insert(file_types, file_type)
			end

			local function setup_and_enable_server(server_name, server_config)
				local server_options = {
					capabilities = vim.tbl_deep_extend(
						"force",
						cmp_status and cmp_lsp.default_capabilities() or {},
						server_config.use_default and vim.lsp.protocol.make_client_capabilities() or {},
						server_config.capabilities or {}
					),
					on_attach = server_config.on_attach,
					on_new_config = server_config.on_new_config,
					settings = server_config.settings,
					cmd = server_config.cmd,
				}
				-- Setup server and start it, then remove it form table
				vim.lsp.config(server_name, server_options)
				vim.lsp.enable(server_name)
				opts.servers[server_name] = nil
			end

			-- Configure and enable all servers which are needed by the opened filetype.
			-- To start the server, use '<leader>ll'
			vim.api.nvim_create_autocmd({ "FileType" }, {
				pattern = file_types,
				once = false, -- Run only once for every filetype
				callback = function()
					-- Iterate over all available servers and see if they need to be setup
					for server_name, server_config in pairs(opts.servers) do
						-- Check if any given filetype warrants this server to be setup. If so, set it up and remove it from the table to not set it up again
						for _, server_ft in pairs(server_config.ft) do
							if server_ft == vim.bo.filetype then
								setup_and_enable_server(server_name, server_config)
								break
							end
						end
					end
				end,
			})

			-- Configure, enable and start a specific server on demand
			vim.api.nvim_create_user_command("Lsp", function(cmd_opts)
				local server_name = cmd_opts.args
				local server_config = opts.servers[server_name]
				setup_and_enable_server(server_name, server_config)
				vim.cmd("LspStart")
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
