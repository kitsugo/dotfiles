-- Install Lazy nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable",
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

-- Checks whether a given program is executable/installed on this machine
function Check_Installed(program)
	if vim.fn.executable(program) == 1 then
		return true
	end
	return false
end

require("lazy").setup("user", {
	defaults = {
		lazy = false,
	},
	performance = {
		rtp = {
			paths = { vim.fn.stdpath("data") .. "/site" },
			disabled_plugins = {
				"netrwPlugin",
				"man",
				"shada",
				"tutor",
				"health",
			},
		},
	},
})
