-- https://github.com/williamboman/mason.nvim/blob/main/PACKAGES.md
-- https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md
-- LSP Servers to be setup by lspconfig - Check :Mason
-- Formatters must be installed manually, also check :Mason for this!
LANGUAGES.servers = {
	-- "bashls",
	-- "cssls",
	-- "html",
	"lua_ls",
	-- "ltex",
	-- "perlnavigator",
	-- "texlab",
	-- "tsserver",
}

-- Treesitter languages to be installed - Check :TSInstallInfo
-- FOR WINDOWS: Run nvim once in VisualStudio CMD Console after updating or compile in another way!
LANGUAGES.treesitter = {
	-- "bash",
	-- "html",
	-- "java",
	"lua",
	-- "markdown",
	-- "markdown_inline",
	-- "scala",
}

-- Null-LS sources to be setup - Must still be installed with :Mason
-- Possible types: formatting, diagnostics, code_actions
LANGUAGES.sources = {
	-- eslint_d = {
	-- 	type = "diagnostics",
	-- },
	gitsigns = {
		type = "code_actions",
	},
	-- latexindent = {
	-- 	type = "formatting",
	-- },
	-- prettier = {
	-- 	type = "formatting",
	-- },
	-- shfmt = {
	-- 	type = "formatting",
	-- },
	stylua = {
		type = "formatting",
	},
}
