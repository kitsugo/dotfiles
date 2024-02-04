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

require("lazy").setup("plugins", {
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
