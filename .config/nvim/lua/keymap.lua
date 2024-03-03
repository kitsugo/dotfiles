-- Global keymap configuration
local k = vim.keymap.set
local opts = { silent = true }
vim.g.mapleader = " "
k("", "<Space>", "<Nop>", opts)

-- Window navigation
k("n", "<C-h>", "<C-w>h", opts)
k("n", "<C-j>", "<C-w>j", opts)
k("n", "<C-k>", "<C-w>k", opts)
k("n", "<C-l>", "<C-w>l", opts)
-- Resize window
k("n", "<C-Up>", ":resize -2<CR>", opts)
k("n", "<C-Down>", ":resize +2<CR>", opts)
k("n", "<C-Left>", ":vertical resize +2<CR>", opts)
k("n", "<C-Right>", ":vertical resize -2<CR>", opts)
-- Buffer controls
k("n", "<S-l>", ":bnext<CR>", opts)
k("n", "<S-h>", ":bprevious<CR>", opts)
k("n", "<S-q>", ":bdelete!<CR>:bnext<CR>", opts)
-- Indenting mode
k("v", "<", "<gv", opts)
k("v", ">", ">gv", opts)

k("n", "<leader>h", "<cmd>nohlsearch<CR>", opts) -- Clear highlight
k("n", "x", '"_x', opts) -- Single X deletes but does not cut text
k("v", "p", '"_dP', opts) -- Paste from global register
k("n", "q", "", opts) -- Do not have Q record macros

-- LSP
k("n", "<leader>k", "<cmd>lua vim.diagnostic.open_float()<CR>", opts) -- Open diagnostics
k("n", "<leader>j", "<cmd>lua vim.lsp.buf.hover()<CR>", opts) -- Open documentation
k("n", "<leader>gr", "<cmd>lua vim.lsp.buf.references()<CR>", opts)
k("n", "<leader>gd", "<cmd>lua vim.lsp.buf.definition()<CR>", opts)
k("n", "<leader>gI", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts)
k("n", "<leader>gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", opts)
k("n", "<leader>la", "<cmd>lua vim.lsp.buf.code_action()<cr>", opts)
k("n", "<leader>lA", "<cmd>lua vim.lsp.codelens.run()<cr>", opts)
k("n", "<leader>lr", "<cmd>lua vim.lsp.buf.rename()<cr>", opts)
k("n", "<leader>ls", "<cmd>lua vim.lsp.buf.signature_help()<CR>", opts)
k("n", "<leader>lq", "<cmd>lua vim.diagnostic.setloclist()<CR>", opts)
k("n", "<leader>lj", "<cmd>lua vim.diagnostic.goto_next({buffer=0})<cr>", opts)
k("n", "<leader>lk", "<cmd>lua vim.diagnostic.goto_prev({buffer=0})<cr>", opts)
k("n", "<leader>li", "<cmd>LspInfo<cr>", opts)
-- k("n", "<leader>lf", function()
-- 	vim.lsp.buf.format({
-- 		async = true,
-- 		filter = function(client)
-- 			print(client.name)
-- 			print(client.name == "lua_ls")
-- 			return client.name ~= "html" and client.name ~= "css" and client.name ~= "texlab" and client.name ~= "ltex" and client.name ~= "lua_ls"
-- 		end,
-- 	})
-- end)
--


-- Spawn IDE-like Terminal at the bottom. Requires kitty / Windows terminal
k("n", "<leader>t", function()
	if OS_NAME == "Linux" then
		vim.cmd("silent ! kitty @ --to=$KITTY_LISTEN_ON launch --type window --cwd " .. vim.fn.getcwd())
		vim.cmd("silent ! kitty @ --to=$KITTY_LISTEN_ON resize-window -a vertical -i -16")
	elseif OS_NAME == "Windows_NT" then
		vim.cmd("silent ! wt.exe -w 0 split-pane -H -s .2 -d " .. vim.fn.getcwd())
	end
end, opts)
