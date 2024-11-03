-- Quickly edit config files
vim.api.nvim_create_user_command("EditVimConfig", function()
	local vim_config = vim.fn.stdpath("config")
	vim.cmd("edit " .. vim_config)
	vim.cmd("cd " .. vim_config)
end, {})

-- Opens xxd inside of vim, allowing free hex editing
vim.api.nvim_create_user_command("HexBegin", function()
	vim.bo.bin = true -- Prevent EOL and other artifacts polluting the binary file
	vim.cmd("%!xxd")
end, {})

-- Closes xxd inside vim, saving the hex changes
vim.api.nvim_create_user_command("HexEnd", function()
	vim.cmd("%!xxd -r")
end, {})

-- Turn on spellchecking
vim.api.nvim_create_user_command("Spell", function()
	vim.o.spell = true
	vim.o.spelllang = "en_us,de"
end, {})

-- Setup custom autocommands
local start_up = vim.api.nvim_create_augroup("start_up", { clear = true })

-- Spellchecking
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
