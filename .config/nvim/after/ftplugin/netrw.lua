local utils = require("utils")

--[[ HACK: Remap creating files "%" to "a" and have them be created in the actual viewed directory while using Lexplore.
Lexplore messes with the way files are written (not directories though). This requires "Ccd%" to be used: https://www.reddit.com/r/vim/comments/1agcdkz/lexplore_not_opening_new_file_in_current/
This "fix" creates a new issue of Lexplore no longer behaving as expected and spawning the new buffer inside the netrw split (unlike what Lexplore should do).
To fix this utilize ":w<CR>:bd<CR>" to simply write the created, empty file and immediately close it (as nvim_tree would do). Then just reopen netrw to give the illusion nothing changed. --]]
vim.keymap.set(
	"n",
	"a",
	"Ccd%:w<CR>:let L = expand('%:p')<CR>:bw<CR>:execute ':e' L<CR>:cd" .. START_DIR .. "<CR>",
	{ remap = true, buffer = true }
)

-- Mark files with v
vim.keymap.set("n", "v", "mf", { remap = true, buffer = true })

-- Map going up and down directories to vim direction keys
vim.keymap.set("n", "ll", "<Plug>NetrwLocalBrowseCheck", { noremap = true, buffer = true })
vim.keymap.set("n", "hh", "<Plug>NetrwBrowseUpDir", { noremap = true, buffer = true })

-- Overwrite <C-l> again so it doesn't call Netrw commands
vim.keymap.set("n", "<C-l>", "<C-w>l", { remap = true, buffer = true })

-- Overwrite copy
vim.keymap.set("n", "yp", function()
	local target_dir = vim.b.netrw_curdir
	local file_list = vim.fn["netrw#Expose"]("netrwmarkfilelist")
	print(utils.dump_table(file_list))
	if utils.is_table(file_list) then
		for _, node in pairs(file_list) do
			vim.loop.fs_copyfile(node, target_dir .. "/" .. vim.fs.basename(node), { excl = true })
		end
	end
end, { remap = true, buffer = true })

-- Overwrite move
vim.keymap.set("n", "dp", function()
	local target_dir = vim.b.netrw_curdir
	local file_list = vim.fn["netrw#Expose"]("netrwmarkfilelist")
	print(utils.dump_table(file_list))
	if utils.is_table(file_list) then
		for _, node in pairs(file_list) do
			local file_name = vim.fs.basename(node)
			local target_exists = vim.loop.fs_access(target_dir .. "/" .. file_name, "W")
			if not target_exists then
				vim.loop.fs_rename(node, target_dir .. "/" .. file_name)
			else
				print("File '" .. file_name .. "' already exists! Skipping...")
			end
		end
	end
end, { remap = true, buffer = true })

-- Overwrite rename
vim.keymap.set("n", "r", function()
	local target_dir = vim.b.netrw_curdir
	local old_file_name = vim.fn["netrw#Call"]("NetrwGetWord")
	local new_file_name = vim.fn.input("New Name: ", old_file_name)
	if new_file_name ~= "" then
		local file_exists = vim.loop.fs_access(target_dir .. "/" .. new_file_name, "W")
		if not file_exists then
			vim.loop.fs_rename(target_dir .. "/" .. old_file_name, target_dir .. "/" .. new_file_name)
		else
			print("File '" .. new_file_name .. "' already exists! Skipping...")
		end
	end
end, { remap = true, buffer = true })
