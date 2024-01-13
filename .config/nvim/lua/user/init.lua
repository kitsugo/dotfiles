-- Plugins without elaborate configuration setup
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
			{ "<leader>ww", ':lua require("kiwi").open_wiki_index()<cr>', desc = "Open wiki index" },
			{ "<leader>wt", ':lua require("kiwi").todo.toggle()<cr>',     desc = "Toggle task" },
		},
		lazy = true,
	},
	{ -- Preview Markdown
		"iamcco/markdown-preview.nvim",
		enabled = Check_Installed("node") and Check_Installed("npm"),
		config = function()
			vim.g.mkdp_filetypes = { "markdown" }
			vim.g.mkdp_auto_close = 0
		end,
		build = function()
			vim.fn["mkdp#util#install"]()
		end,
		ft = "markdown",
		lazy = true,
	},
	{ -- Show color of color codes in vim
		"norcalli/nvim-colorizer.lua",
		config = function()
			require("colorizer").setup()
		end,
	},
	{ -- Dedicated Java LSP
		"mfussenegger/nvim-jdtls",
		enabled = Check_Installed("javac"),
		ft = "java",
	},
	{ -- Dedicated Scala LSP
		"scalameta/nvim-metals",
		enabled = Check_Installed("scala") and Check_Installed("cs"),
		ft = "scala",
	},
	{ -- Dedicated Assembly LSP
		"ARM9/snes-syntax-vim",
		enabled = Check_Installed("ca65") and Check_Installed("bsnes"),
		ft = "snes",
	},
}
