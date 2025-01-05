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
					-- Remove starting empty buffer
					utils.clean_empty_bufs()
					-- Deactivate browsing file viewer
					vim.keymap.set("", "<leader>e", "<Nop>", { silent = true })
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
		config = function(_, opts)
			vim.api.nvim_create_user_command("Zet", function(opts)
				local id = os.date("%y%m%d%H%M")
				local name = opts.args
				local fileName = string.lower(opts.args:gsub(" ", "_"))
				local line = "[" .. id .. " " .. name .. "]" .. "(" .. "./" .. id .. "_" .. fileName .. ".md" .. ")"
				vim.api.nvim_set_current_line(line)
			end, { nargs = "?" })
			require("kiwi").setup(opts)
		end,
	},
}
