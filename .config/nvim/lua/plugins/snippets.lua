-- Activate additional snippets on demand with command
return {
	"honza/vim-snippets",
	cmd = "SnippetsOn",
	dependencies = {
		{
			"L3MON4D3/LuaSnip",
		},
	},
	config = function()
		vim.api.nvim_create_user_command("SnippetsOn", function()
			require("luasnip.loaders.from_snipmate").lazy_load()
		end, {})
	end,
}
