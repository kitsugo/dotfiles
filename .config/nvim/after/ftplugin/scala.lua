local metals_status, metals = pcall(require, "metals")
if metals_status then
	metals.initialize_or_attach(require("plugins.lsp.servers.standalone.metals"))
end
