-- Plugins without elaborate configuration setup
return {
	{
		"iamcco/markdown-preview.nvim",
		enabled = check_installed("node") and check_installed("npm"),
		config = function()
			vim.g.mkdp_filetypes = { "markdown" }
			vim.g.mkdp_auto_close = 0
		end,
		build = function()
			vim.fn["mkdp#util#install"]()
		end,
		ft = "markdown",
	},
	{
		"norcalli/nvim-colorizer.lua",
		config = function()
			require("colorizer").setup()
		end,
	},
	{
		"mfussenegger/nvim-jdtls",
		enabled = check_installed("javac"),
		ft = "java",
	},
	{
		"scalameta/nvim-metals",
		enabled = check_installed("scala") and check_installed("cs"),
		ft = "scala",
	},
	{
		"ARM9/snes-syntax-vim",
		enabled = check_installed("ca65") and check_installed("bsnes"),
		ft = "snes",
	},
}
