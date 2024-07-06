-- Quickly edit config files
vim.api.nvim_create_user_command("EditVimConfig", function()
	local vim_config = vim.fn.stdpath("config")
	vim.cmd("edit " .. vim_config)
	vim.cmd("cd " .. vim_config)
end, {})

-- Setup custom autocommands
local start_up = vim.api.nvim_create_augroup("start_up", { clear = true })

-- Spellchecking
vim.api.nvim_create_autocmd({ "FileType" }, {
	pattern = { "text", "markdown", "gitcommit" },
	group = start_up,
	command = "setlocal spell spelllang=en_us,de",
})
-- Close info buffers with "q"
vim.api.nvim_create_autocmd({ "FileType" }, {
	pattern = { "qf", "help", "man", "lspinfo", "spectre_panel" },
	group = start_up,
	callback = function()
		vim.cmd([[
		nnoremap <silent> <buffer> q :close<CR>
		set nobuflisted
    ]])
	end,
})
-- Open git files in insert mode and mark line length
vim.api.nvim_create_autocmd({ "FileType" }, {
	pattern = { "gitcommit", "gitrebase" },
	group = start_up,
	callback = function()
		vim.cmd([[
		startinsert | 1
		set colorcolumn=72
		]])
	end,
})

vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
	pattern = "*.mdx",
	command = "set ft=markdown",
})
