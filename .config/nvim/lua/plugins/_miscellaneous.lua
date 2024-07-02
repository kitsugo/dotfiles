local utils = require("utils")

return {
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
		"JosefLitos/colorizer.nvim",
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
