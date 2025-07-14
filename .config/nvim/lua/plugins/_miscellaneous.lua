local utils = require("utils")

return {
	{ -- Preview Markdown
		"MeanderingProgrammer/render-markdown.nvim",
		dependencies = { "nvim-treesitter/nvim-treesitter", "nvim-tree/nvim-web-devicons" },
		keys = {
			{
				"<leader>fp",
				function()
					require("render-markdown").enable()
				end,
			},
		},
	},
	{ -- Render images inside of neovim with kitty
		"3rd/image.nvim",
		enabled = utils.is_installed("kitty"),
		build = false,
		opts = {
			backend = "kitty",
			processor = "magick_cli",
		},
		keys = {
			{
				"<leader>fp",
				function()
					require("image").enable()
				end,
			},
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
