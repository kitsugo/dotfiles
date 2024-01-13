local snippets_status, snippets = pcall(require, "luasnip.loaders.from_snipmate")
vim.opt.conceallevel = 1 -- Conceal markdown syntax to make it readable as a pure text file
vim.keymap.set("n", "<leader>fp", ":MarkdownPreviewToggle<CR>", { silent = true }) -- Preview markdown file

-- Load markdown setup (normal / fast note taking) depending on user choice.
if not MARKDOWN_TYPE then
	MARKDOWN_TYPE = "t"
		.. vim.fn.inputlist({
			"You opened a markdown file. Are you writing notes quickly?",
			"0. No",
			"1. Yes",
		})
end
if MARKDOWN_TYPE == "t1" then
	-- Have <CR> create actual newlines by appending two spaces.
	-- Use Shift+Enter to have a "normal" carriage return. Requires that terminal handles the input correctly. (send escape sequence "\u001b[13;2u" on shift+enter)
	vim.keymap.set("i", "<CR>", "  <CR>", { silent = true })
	vim.keymap.set("i", "<S-CR>", "<CR>", { silent = true })
	vim.keymap.set("i", "<C-CR>", "\\\\<CR>", { silent = true })
	vim.keymap.set("i", "<C-J>", "\\\\<CR>", { silent = true }) -- Windows sees this as <C-CR>

	if snippets_status and not SNIP_SET then -- Only load fast markdown snippets in fast mode
		snippets.lazy_load({ include = { "markdown" }, paths = { vim.fn.stdpath("config") .. "/snippets/" } })
		SNIP_SET = true
	end
else
	if snippets_status and not SNIP_SET then -- Load all markdown snippets in normal mode
		snippets.lazy_load({ include = { "markdown", "all" } })
		SNIP_SET = true
	end
end
