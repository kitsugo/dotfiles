-- Setup attributes of each LSP and its default options
local status_cmp, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
if not status_cmp then
	return
end

local _M = {}
_M.capabilities = vim.lsp.protocol.make_client_capabilities()
_M.capabilities.textDocument.completion.completionItem.snippetSupport = true
_M.capabilities = cmp_nvim_lsp.default_capabilities(_M.capabilities)

-- Options to be called when the server is setup
_M.setup = function()
	local signs = {
		{ name = "DiagnosticSignError", text = "" },
		{ name = "DiagnosticSignWarn",  text = "" },
		{ name = "DiagnosticSignHint",  text = "" },
		{ name = "DiagnosticSignInfo",  text = "" },
	}

	for _, sign in ipairs(signs) do
		vim.fn.sign_define(sign.name, { texthl = sign.name, text = sign.text, numhl = "" })
	end

	local config = {
		virtual_text = false,
		signs = {
			active = signs,
		},
		update_in_insert = true,
		underline = true,
		severity_sort = true,
		float = {
			focusable = false,
			style = "minimal",
			source = "always",
			header = "",
			prefix = "",
		},
	}
	vim.diagnostic.config(config)
end

-- Options to be called when the server is attached to buffer
_M.on_attach = function(client, bufnr)
	-- if client.name == "html" then
	-- 	print("stop")
	-- 	client.resolved_capabilities.document_formatting = false
	-- 	client.resolved_capabilities.document_range_formatting = false
	-- 	client.server_capabilities.documentFormattingProvider = false
	-- end
	--
	--
	-- if client.name == "tsserver" then
	-- 	client.resolved_capabilities.document_formatting = false
	-- 	client.resolved_capabilities.document_range_formatting = false
	-- 	client.server_capabilities.documentFormattingProvider = false
	-- end
end

return _M
