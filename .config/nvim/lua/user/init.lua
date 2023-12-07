-- Plugins without elaborate configuration setup
return {
	{
		"serenevoid/kiwi.nvim",
		dependencies = {
			"nvim-lua/plenary.nvim",
		},
		opts = {
			{
				name = "General",
				path = os.getenv("HOME") .. "/.dotfiles/extra/gtd/wiki",
			},
		},
		keys = {
			{ "<leader>ww", ':lua require("kiwi").open_wiki_index()<cr>', desc = "Open Wiki index" },
		},
		lazy = true,
	},
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
