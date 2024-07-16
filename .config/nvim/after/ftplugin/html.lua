local snippets_status, snippets = pcall(require, "luasnip.loaders.from_snipmate")

vim.api.nvim_create_user_command("FastNote", function()
	snippets.lazy_load({ include = { "markdown", "html" }, paths = { vim.fn.stdpath("config") .. "/snippets/" } })
	print("Done!")
end, {})

