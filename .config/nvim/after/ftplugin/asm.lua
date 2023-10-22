-- Load specific syntax and snippets depending the type of assembly file chosen on initial startup.
local snippets_status, snippets = pcall(require, "luasnip.loaders.from_snipmate")
local assembly_types = {
	t0 = {
		command = "set filetype=asm",
		pattern = "*.asm,*.s,*.inc",
	},
	t2 = {
		command = "set filetype=snes",
		pattern = "*.asm,*.s,*.inc,*.cfg",
	},
}

if not ASM_TYPE then
	ASM_TYPE = "t"
		.. vim.fn.inputlist({
			"You opened an assembly file. What kind of assembly are you running?",
			"0. x86 (GAS)",
			"2. 65816 (SNES)",
		})
end

-- Setup autocommands to apply decision to all future files
vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
	group = vim.api.nvim_create_augroup("assembly", { clear = true }),
	pattern = assembly_types[ASM_TYPE].pattern,
	command = assembly_types[ASM_TYPE].command,
})
-- Set specific filetype once and update syntax to apply it
vim.cmd(assembly_types[ASM_TYPE].command)
vim.cmd("syntax on")

if snippets_status then
	snippets.lazy_load({ paths = vim.fn.stdpath("config") .. "/snippets/" })
end
