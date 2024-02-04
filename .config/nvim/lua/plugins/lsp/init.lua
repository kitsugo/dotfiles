-- LSP / Linter / Formatter setups
package.path = DOTFILES_PATH .. ".dotfiles/?.lua;" .. package.path
local lang_status, _ = pcall(require, "lsp_config")
if not lang_status then
	print(
		"LSP server configuration not found. Please create " .. DOTFILES_PATH .. ".dotfiles/lsp_config.lua\n:EditLspConfig"
	)
	return
end

return { import = "plugins.lsp" }
