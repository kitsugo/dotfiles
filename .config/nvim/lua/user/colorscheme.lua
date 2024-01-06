-- Set colorscheme and define commands to quickly change it.
local M = {
	"EdenEast/nightfox.nvim",
	lazy = false,
	priority = 1000,
}

function M.config()
	local status_cs, cs = pcall(require, "nightfox")
	if not status_cs then
		return
	end

	vim.api.nvim_create_user_command("ColorLightmode", function()
		vim.cmd("colorscheme dayfox")
		vim.cmd("silent ! colorscheme.sh dayfox")
	end, {})
	vim.api.nvim_create_user_command("ColorDarkmode", function()
		vim.cmd("colorscheme nightfox")
		vim.cmd("silent ! colorscheme.sh nightfox")
	end, {})

	cs.setup({
		options = {
			transparent = true,
			styles = {
				comments = "italic",
				constants = "bold",
				operators = "italic,bold",
			},
		},
	})

	if OS_NAME == "Linux" then
		return update_colorscheme()
	end
	vim.cmd("colorscheme nightfox")
end

return M
