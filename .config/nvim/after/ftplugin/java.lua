local jdtls_status, jdtls = pcall(require, "jdtls")
if jdtls_status then
	vim.cmd("silent ! mkdir -p /tmp/java_bin")
	jdtls.start_or_attach(require("user.lsp.settings.jdtls"))
	vim.keymap.set("n", "<leader>ft", jdtls.test_nearest_method, { silent = true })
	vim.keymap.set("n", "<leader>fT", jdtls.test_class, { silent = true })
end
