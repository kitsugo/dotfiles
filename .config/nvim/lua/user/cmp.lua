-- Completion engine setup
local M = {
	"hrsh7th/nvim-cmp",
	dependencies = {
		{
			"L3MON4D3/LuaSnip",
			dependencies = {
				"honza/vim-snippets",
			},
		},
		{ "hrsh7th/cmp-buffer" },
		{ "hrsh7th/cmp-path" },
		{ "hrsh7th/cmp-nvim-lsp" },
		{ "saadparwaiz1/cmp_luasnip" },
		{ "rcarriga/cmp-dap" },
	},
}

function M.config()
	local cmp = require("cmp")
	local snip = require("luasnip")

	-- Load snipmate snippets, but exclude unwanted
	require("luasnip.loaders.from_snipmate").lazy_load({
		exclude = { "all", "markdown", "assembly" },
	})

	local check_backspace = function()
		local col = vim.fn.col(".") - 1
		return col == 0 or vim.fn.getline("."):sub(col, col):match("%s")
	end

	cmp.setup({
		snippet = {
			expand = function(args)
				snip.lsp_expand(args.body)
			end,
		},
		mapping = cmp.mapping.preset.insert({
			["<C-b>"] = cmp.mapping(cmp.mapping.scroll_docs( -1), { "i", "c" }),
			["<C-f>"] = cmp.mapping(cmp.mapping.scroll_docs(1), { "i", "c" }),
			["<C-Space>"] = cmp.mapping(cmp.mapping.complete(), { "i", "c" }),
			["<S-CR>"] = cmp.mapping({ i = cmp.mapping.abort(), c = cmp.mapping.close() }),
			["<CR>"] = cmp.mapping.confirm({ select = true }),
			["<Tab>"] = cmp.mapping(function(fallback)
				if cmp.visible() then
					cmp.select_next_item()
				elseif snip.expandable() then
					snip.expand({})
				elseif snip.expand_or_jumpable() then
					snip.expand_or_jump()
				elseif check_backspace() then
					fallback()
				else
					fallback()
				end
			end, { "i", "s" }),
			["<S-Tab>"] = cmp.mapping(function(fallback)
				if cmp.visible() then
					cmp.select_prev_item()
				elseif snip.jumpable( -1) then
					snip.jump( -1)
				else
					fallback()
				end
			end, { "i", "s" }),
		}),
		sources = {
			{ name = "nvim_lsp" },
			{ name = "luasnip" },
			{ name = "buffer" },
			{ name = "path" },
		},
		formatting = {
			fields = { "kind", "abbr", "menu" },
			format = function(entry, vim_item)
				vim_item.kind = ({
						Text = "󰉿",
						Method = "󰊕",
						Function = "󰊕",
						Constructor = "",
						Field = "",
						Variable = "",
						Class = "󰌗",
						Interface = "",
						Module = "",
						Property = "",
						Unit = "",
						Value = "󰎠",
						Enum = "",
						Keyword = "󰌋",
						Snippet = "",
						Color = "󰏘",
						File = "",
						Reference = "",
						Folder = "",
						EnumMember = "",
						Constant = "",
						Struct = "",
						Event = "",
						Operator = "󰆕",
						TypeParameter = "󰊄",
						Codeium = "󰚩",
						Copilot = "",
					})[vim_item.kind]
				vim_item.menu = ({
						nvim_lsp = "[LSP]",
						luasnip = "[SNIP]",
						buffer = "[BUFFER]",
						path = "[PATH]",
					})[entry.source.name]
				return vim_item
			end,
		},
		window = {
			documentation = cmp.config.window.bordered(),
		},
		enabled = function()
			return vim.api.nvim_buf_get_option(0, "buftype") ~= "prompt" or require("cmp_dap").is_dap_buffer()
		end,
	})

	-- No buffer completion for word-only files
	cmp.setup.filetype({ "markdown", "text" }, {
		sources = cmp.config.sources({
			{ name = "nvim_lsp" },
			{ name = "luasnip" },
			{ name = "path" },
		}),
	})

	-- DAP REPL Completion
	cmp.setup.filetype({ "dap-repl", "dapui_watches", "dapui_hover" }, {
		sources = {
			{ name = "dap" },
			{ name = "luasnip" },
			{ name = "path" },
		},
	})

	-- Custom rules for appending pairs when choosing a completion option
	local autopair_status, cmp_autopairs = pcall(require, "nvim-autopairs.completion.cmp")
	if autopair_status then
		local handlers = require("nvim-autopairs.completion.handlers")
		cmp.event:on(
			"confirm_done",
			cmp_autopairs.on_confirm_done({
				filetypes = {
					plaintex = {
						["{"] = {
							kind = {
								cmp.lsp.CompletionItemKind.Function,
								cmp.lsp.CompletionItemKind.Method,
							},
							handler = handlers["*"],
						},
					},
					tex = {
						["{"] = {
							kind = {
								cmp.lsp.CompletionItemKind.Function,
								cmp.lsp.CompletionItemKind.Method,
							},
							handler = handlers["*"],
						},
					},
					sh = {
						[""] = {
							kind = {
								cmp.lsp.CompletionItemKind.Function,
								cmp.lsp.CompletionItemKind.Method,
							},
							handler = handlers["*"],
						},
					},
				},
			})
		)
	end
end

return M
