-- Configure autocommands and events to insert template (skeleton) files when needed
local template = vim.api.nvim_create_augroup("template", { clear = true })
local template_location = vim.fn.stdpath("config") .. "/templates/"

vim.api.nvim_create_autocmd({ "BufNewFile" }, {
	group = template,
	pattern = "*.sh",
	command = "0put =readfile('" .. template_location .. "shebang.sh" .. "')[0:0]"
})
vim.api.nvim_create_autocmd({ "BufNewFile" }, {
	group = template,
	pattern = "*.pl",
	command = "0put =readfile('" .. template_location .. "shebang.sh" .. "')[1:1]"
})
vim.api.nvim_create_autocmd({ "BufNewFile" }, {
	group = template,
	pattern = "*.py",
	command = "0put =readfile('" .. template_location .. "shebang.sh" .. "')[2:2]"
})
vim.api.nvim_create_autocmd({ "BufNewFile" }, {
	group = template,
	pattern = "*.lua",
	command = "0put =readfile('" .. template_location .. "shebang.sh" .. "')[3:3]"
})
vim.api.nvim_create_autocmd({ "BufNewFile" }, {
	group = template,
	pattern = "*.ps1",
	command = "0put =readfile('" .. template_location .. "shebang.sh" .. "')[4:4]"
})
vim.api.nvim_create_autocmd({ "BufNewFile" }, {
	group = template,
	pattern = "index.html",
	command = "0r " .. template_location .. "template.html",
})

vim.api.nvim_create_autocmd({ "BufNewFile" }, {
	group = template,
	pattern = "lsp_config.lua",
	command = "0r " .. template_location .. "lsp_config.lua",
})
vim.api.nvim_create_autocmd({ "BufNewFile" }, {
	group = template,
	pattern = "dotfiles_profile.sh",
	command = "0r " .. template_location .. "dotfiles_profile.sh",
})

