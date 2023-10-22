local metals_status, metals = pcall(require, "metals")
if metals_status then
	metals.initialize_or_attach(require("user.lsp.settings.metals"))
end
