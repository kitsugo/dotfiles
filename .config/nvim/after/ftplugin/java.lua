local jdtls_status, jdtls = pcall(require, "jdtls")
if jdtls_status then
	jdtls.start_or_attach(require("plugins.lsp.settings.jdtls"))

	local config_location = vim.fn.stdpath("config") .. "/configs/"
	local project_dir = vim.fs.dirname(vim.fs.find({ "src" }, { upward = true })[1])
	vim.keymap.set("n", "<leader>ft", jdtls.test_nearest_method, { silent = true })
	vim.keymap.set("n", "<leader>fT", jdtls.test_class, { silent = true })

	vim.api.nvim_create_user_command("StartJavaProject", function()
		local buffer = vim.fn.expand("%:p")
		vim.cmd(":JdtCompile<cr>")
		vim.cmd(
			":term ! "
				.. config_location
				.. "build_java.sh "
				.. vim.fs.basename(project_dir)
				.. " "
				.. vim.fs.basename(vim.fs.dirname(buffer))
				.. "."
				.. vim.fs.basename(buffer):sub(1, -6)
		)
	end, {})
end
