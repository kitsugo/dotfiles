local utils = require("utils")

return {
	{ -- Preview Markdown
		"jannis-baum/vivify.vim",
		enabled = utils.is_installed("viv") and utils.is_installed("vivify-server"),
		keys = {
			{ "<leader>fp", ":Vivify<cr>" },
		},
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
}
