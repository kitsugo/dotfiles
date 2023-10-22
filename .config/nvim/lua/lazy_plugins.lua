-- Get lazy nvim
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
function check_installed(program)
	if vim.fn.executable(program) == 1 then
		return true
	end
	return false
end

-- Updates the colorscheme depending on the current globally set theme on Linux
function update_colorscheme()
	local status_cf, colorFile = pcall(vim.fn.readfile, "/tmp/current_theme.conf", 1)
	if status_cf and colorFile[1] == "#light" then
		vim.cmd("colorscheme dayfox")
	else
		vim.cmd("colorscheme nightfox")
	end
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
