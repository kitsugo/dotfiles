local utils = require("utils")

return {
	{ -- Minimal VimWiki
		"serenevoid/kiwi.nvim",
		dependencies = {
			"nvim-lua/plenary.nvim",
		},
		opts = {
			{
				name = "general",
				path = os.getenv("HOME") .. "/.dotfiles/extra/gtd/wiki",
			},
		},
		keys = {
			{
				"<leader>ww",
				function()
					require("kiwi").open_wiki_index()
				end,
				desc = "Open wiki index",
			},
			{
				"<leader>wt",
				function()
					require("kiwi").todo.toggle()
				end,
				desc = "Toggle task",
			},
		},
	},
	{ -- Preview Markdown
		"iamcco/markdown-preview.nvim",
		enabled = utils.is_installed("node") and utils.is_installed("npm"),
		config = function()
			vim.g.mkdp_filetypes = { "markdown" }
			vim.g.mkdp_auto_close = 0
		end,
		build = function()
			vim.fn["mkdp#util#install"]()
		end,
		ft = "markdown",
	},
	{ -- Show color of color codes in vim
		"norcalli/nvim-colorizer.lua",
		config = function()
			require("colorizer").setup()
		end,
		keys = {
			{ "<leader>wb", ":ColorizerAttachToBuffer<cr>" },
		},
		ft = { "html", "css" },
	},
	{ -- Dedicated Java LSP
		"mfussenegger/nvim-jdtls",
		enabled = utils.is_installed("javac"),
		ft = "java",
	},
	{ -- Dedicated Scala LSP
		"scalameta/nvim-metals",
		enabled = utils.is_installed("scala") and utils.is_installed("cs"),
		ft = "scala",
	},
	{ -- SNES assembly syntax
		"ARM9/snes-syntax-vim",
		enabled = utils.is_installed("ca65") and utils.is_installed("bsnes"),
		ft = "snes",
	},
}
