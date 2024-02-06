-- Nvim-Tree Setup
local utils = require("utils")
local M = {
	"kyazdani42/nvim-tree.lua",
	keys = {
		{ "<leader>e", ":NvimTreeToggle<CR>" },
	},
	lazy = not utils.num_to_bool(vim.fn.isdirectory(vim.fn.expand("%:p"))),
}

function M.config()
	local nvim_tree = require("nvim-tree")
	local nvimtree_api = require("nvim-tree.api")

	vim.keymap.set("n", "<leader>e", ":NvimTreeToggle<CR>", { silent = true })
	nvimtree_api.events.subscribe(nvimtree_api.events.Event.FileCreated, function(file)
		vim.cmd("edit " .. file.fname)
		vim.cmd("doautocmd BufNewFile")
	end)

	local open_nvim_tree = function(data)
		local directory = vim.fn.isdirectory(data.file) == 1
		if not directory then
			return
		end
		vim.cmd.cd(data.file)
		require("nvim-tree.api").tree.open()
	end

	vim.api.nvim_create_autocmd({ "VimEnter" }, { callback = open_nvim_tree })

	nvim_tree.setup({
		disable_netrw = true,
		diagnostics = {
			enable = true,
		},
		renderer = {
			group_empty = false,
		},
	})
end

return M
