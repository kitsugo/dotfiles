-- Set colorscheme and define commands to quickly change it.
local M = {
	"EdenEast/nightfox.nvim",
	lazy = false,
	priority = 1000,
}

-- Updates the colorscheme depending on the current globally set theme on Linux
local function update_colorscheme()
	local status_cf, colorFile = pcall(vim.fn.readfile, "/tmp/colorscheme/name.txt", 1)
	if status_cf then
		vim.cmd("colorscheme " .. colorFile[1])
	end
end

function M.config()
	vim.keymap.set("n", "<leader>c", function()
		update_colorscheme()
	end)

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
	else
		vim.cmd("colorscheme nightfox")
	end
end

return M
