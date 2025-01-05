local utils = require("utils")

-- Clean up netrw's empty buffer artifacts and let that logic toggle it
local function toggle_netrw(use_local)
	utils.clean_empty_bufs()
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
		if use_local then
			vim.cmd(":Lexplore %:p:h")
		else
			vim.cmd(":Lexplore")
		end
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
				toggle_netrw(true)
			end,
		},
		{
			"<leader><S-e>",
			function()
				toggle_netrw(false)
			end,
		},
	},
	event = "BufEnter */*",
	lazy = not utils.num_to_bool(vim.fn.isdirectory(vim.fn.expand("%:p"))),
	config = function()
		START_DIR = vim.fn.getcwd()
		require("netrw").setup()

		vim.api.nvim_create_autocmd({ "BufEnter" }, {
			pattern = "*/*",
			callback = function()
				if utils.num_to_bool(vim.fn.isdirectory(vim.fn.expand("%:p"))) then
					vim.cmd(":bd")
					toggle_netrw(false)
				end
			end,
			once = true,
		})
	end,
}
