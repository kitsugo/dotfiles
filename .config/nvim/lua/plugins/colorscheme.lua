-- Set colorscheme and define commands to quickly change it.
--

-- Updates the colorscheme depending on the current globally set theme on Linux
function update_colorscheme()
	if OS_NAME == "Linux" then
		local status_cf, colorFile = pcall(vim.fn.readfile, "/tmp/colorscheme/name.txt", 1)
		if status_cf then
			vim.cmd("colorscheme " .. colorFile[1])
		else
			vim.cmd("colorscheme nightfox")
		end
	else
		vim.cmd("colorscheme nightfox")
	end
end

vim.keymap.set("n", "<leader>c", function()
	update_colorscheme()
end)

return {
	{
		"EdenEast/nightfox.nvim",
		lazy = true,
		opts = {
			transparent = true,
			styles = {
				comments = "italic",
				constants = "bold",
				operators = "italic,bold",
			},
		},
	},
	{
		"folke/tokyonight.nvim",
		lazy = true,
		opts = {
			style = "night",
			transparent = true,
		},
	},
}
