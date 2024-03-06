-- HACK: Remap creating files "%" to "a" and have them be created in the actual viewed directory while using Lexplore.
-- Lexplore messes with the way files are written (not directories though). This requires "Ccd%" to be used: https://www.reddit.com/r/vim/comments/1agcdkz/lexplore_not_opening_new_file_in_current/
-- This "fix" creates a new issue of Lexplore no longer behaving as expected and spawning the new buffer inside the netrw split (unlike what Lexplore should do).
-- To fix this utilize ":w<CR>:bd<CR>" to simply write the file empty and close it (as nvim_tree would do). Then just reopen netrw to give the illusion nothing changed.
-- Must use "set autochdir" so netrw is actually reopened in the viewed directory. Sadly this won't happen when switching directories before
vim.keymap.set("n", "a", "Ccd%:w<CR>:bw<CR>:Lexplore<CR>", { remap = true, buffer = true })
-- Mark files with v
vim.keymap.set("n", "v", "mf", { remap = true, buffer = true })
-- Mark directory with shift v
vim.keymap.set("n", "<S-v>", "mt:echom 'Marked directory!'<CR>", { remap = true, buffer = true })



