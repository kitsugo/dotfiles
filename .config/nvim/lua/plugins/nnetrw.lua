local utils = require("utils")

-- Remove all empty "No Name" buffers that are unmodified
local function clean_empty_bufs()
	for _, buf in pairs(vim.api.nvim_list_bufs()) do
		if
			vim.api.nvim_buf_get_name(buf) == ""
			and not vim.api.nvim_buf_get_option(buf, "modified")
			and vim.api.nvim_buf_is_loaded(buf)
		then
			vim.api.nvim_buf_delete(buf, {})
		end
	end
end

-- Clean up netrw's empty buffer artifacts and let that logic toggle it
local function toggle_netrw()
	clean_empty_bufs()
	local flag = false
	for _, buf in pairs(vim.api.nvim_list_bufs()) do
		local e, v = pcall(function()
			-- Must use this over vim.b.current_syntax since otherwise other buffers get deleted
			return vim.api.nvim_buf_get_var(buf, "current_syntax")
		end)
		if
			(e and v == "netrwlist")
			and not vim.api.nvim_buf_get_option(buf, "modified")
			and vim.api.nvim_buf_is_loaded(buf)
		then
			flag = true
			vim.api.nvim_buf_delete(buf, {})
		end
	end

	if not flag then
		vim.cmd(":Lexplore")
	end
end

-- Use netrw with some nice icons as primary file browser.
-- All code related to netrw is basically just hacks to make up for its buggy state.
return {
	"prichrd/netrw.nvim",
	dependencies = {
		{ "nvim-tree/nvim-web-devicons" },
	},
	keys = {
		{
			"<leader>e",
			function()
				toggle_netrw()
			end,
		},
	},
	branch = "more-list-styles",
	lazy = not utils.num_to_bool(vim.fn.isdirectory(vim.fn.expand("%:p"))),
	config = function()
		require("netrw").setup()
	end,
}
