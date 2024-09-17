-- Load fast note taking markdown setup
vim.api.nvim_create_user_command("FastNote", function()
	-- Have <CR> create actual newlines by appending two spaces.
	-- Use Shift+Enter to have a "normal" carriage return. Requires that terminal handles the input correctly. (send escape sequence "\u001b[13;2u" on shift+enter)
	vim.keymap.set("i", "<CR>", "  <CR>", { silent = true })
	vim.keymap.set("i", "<S-CR>", "<CR>", { silent = true })
	vim.keymap.set("i", "<C-CR>", "\\\\<CR>", { silent = true })
	vim.keymap.set("i", "<C-J>", "\\\\<CR>", { silent = true }) -- Windows sees this as <C-CR>

	-- Load LaTeX snippets
	local snippets_status, snippets = pcall(require, "luasnip.loaders.from_snipmate")
	if snippets_status then
		snippets.lazy_load({ include = { "markdown" }, paths = { vim.fn.stdpath("config") .. "/snippets/" } })
	end
	-- Conceal markdown syntax to make it readable as a pure text file
	vim.opt.conceallevel = 1
end, {})
