local utils = require("utils")

-- HACK: Remap creating files "%" to "a" and have them be created in the actual viewed directory while using Lexplore.
-- Lexplore messes with the way files are written (not directories though). This requires "Ccd%" to be used: https://www.reddit.com/r/vim/comments/1agcdkz/lexplore_not_opening_new_file_in_current/
-- This "fix" creates a new issue of Lexplore no longer behaving as expected and spawning the new buffer inside the netrw split (unlike what Lexplore should do).
-- To fix this utilize ":w<CR>:bd<CR>" to simply write the file empty and close it (as nvim_tree would do). Then just reopen netrw to give the illusion nothing changed.
-- Must use "set autochdir" so netrw is actually reopened in the viewed directory. Sadly this won't happen when switching directories before
vim.keymap.set("n", "a", "Ccd%:w<CR>:let L = expand('%:p')<CR>:bw<CR>:execute ':e' L<CR>:cd" .. START_DIR .. "<CR>", { remap = true, buffer = true })
-- Mark files with v
vim.keymap.set("n", "v", "mf", { remap = true, buffer = true })
vim.keymap.set("n", "r", "R", { remap = true, buffer = true })
-- Map going up and down directories to vim direction keys
vim.keymap.set("n", "ll", "<Plug>NetrwLocalBrowseCheck", { noremap = true, buffer = true })
vim.keymap.set("n", "hh", "<Plug>NetrwBrowseUpDir", { noremap = true, buffer = true })
-- Overwrite <C-l> again so it doesn't call Netrw commands
vim.keymap.set("n", "<C-l>", "<C-w>l", { remap = true, buffer = true })
-- Overwrite cp of netrw. Does not work with directories yet
vim.keymap.set("n", "yp", function()
	local target = vim.b.netrw_curdir
	local file_list = vim.fn["netrw#Expose"]("netrwmarkfilelist")
	print(utils.dump_table(file_list))
	if utils.is_table(file_list) then
		for _, node in pairs(file_list) do
			vim.loop.fs_copyfile(node, target .. "/" .. vim.fs.basename(node), { excl = true })
		end
	end
end, { remap = true, buffer = true })
-- Overwrite mv of netrw
vim.keymap.set("n", "dp", function()
	local target = vim.b.netrw_curdir
	local file_list = vim.fn["netrw#Expose"]("netrwmarkfilelist")
	print(utils.dump_table(file_list))
	if utils.is_table(file_list) then
		for _, node in pairs(file_list) do
			local target_exists = vim.loop.fs_access(target .. "/" .. vim.fs.basename(node), "W")
			if not target_exists then
				vim.loop.fs_rename(node, target .. "/" .. vim.fs.basename(node))
			end
		end
	end
end, { remap = true, buffer = true })
