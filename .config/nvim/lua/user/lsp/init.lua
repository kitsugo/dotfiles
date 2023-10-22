-- LSP / Linter / Formatter setups
package.path = DOTFILES .. ".dotfiles/?.lua;" .. package.path
local lang_status, _ = pcall(require, "lsp_config")
if not lang_status then
	print(
		"LSP server configuration not found. Please create " .. DOTFILES .. ".dotfiles/lsp_config.lua\n:EditLspConfig"
	)
end

return { import = "user.lsp" }
