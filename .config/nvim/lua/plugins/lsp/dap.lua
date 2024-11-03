local M = {
	"mfussenegger/nvim-dap",
	dependencies = {
		{ "rcarriga/nvim-dap-ui" },
		{ "rcarriga/cmp-dap" },
	},
	keys = { "<leader>dr" },
}

function M.config()
	-- Debug Adapter setup
	local dap_status, dap = pcall(require, "dap")
	local dapui_status, dapui = pcall(require, "dapui")
	if not dap_status or not dapui_status then
		return
	end
	
	-- Set DAP keybindings
	vim.keymap.set("n", "<leader>dc", function()
		dap.continue()
	end)
	vim.keymap.set("n", "<leader>dr", function()
		dap.repl.toggle()
	end)
	vim.keymap.set("n", "<leader>db", function()
		dap.toggle_breakpoint()
	end)
	vim.keymap.set("n", "<leader>di", function()
		dap.step_into()
	end)
	vim.keymap.set("n", "<leader>do", function()
		dap.step_over()
	end)
	vim.keymap.set("n", "<leader>dO", function()
		dap.step_out()
	end)
	vim.keymap.set("n", "<leader>dt", function()
		dap.terminate()
		dapui.close()
	end)
	vim.keymap.set("n", "<leader>dK", function()
		require.hover()
	end)
	vim.keymap.set("n", "<leader>dl", function()
		dap.run_last()
	end)

	-- Always format REPL as 'unix' to avoid displaying unwanted characters
	vim.api.nvim_create_autocmd({ "FileType" }, {
		pattern = { "dap-repl" },
		callback = function()
			vim.cmd("set ff=unix")
		end,
	})

	dapui.setup({
		expand_lines = true,
		icons = { expanded = "", collapsed = "", circular = "" },
		mappings = {
			expand = { "<CR>", "<2-LeftMouse>" },
			open = "o",
			remove = "d",
			edit = "e",
			repl = "r",
			toggle = "t",
		},
		layouts = {
			{
				elements = {
					{ id = "scopes", size = 0.33 },
					{ id = "breakpoints", size = 0.17 },
					{ id = "stacks", size = 0.25 },
					{ id = "watches", size = 0.25 },
				},
				size = 0.33,
				position = "right",
			},
			{
				elements = {
					{ id = "repl", size = 0.65 },
					{ id = "console", size = 0.35 },
				},
				size = 0.27,
				position = "bottom",
			},
		},
		floating = {
			max_height = 0.9,
			max_width = 0.5,
			border = vim.g.border_chars,
			mappings = {
				close = { "q", "<Esc>" },
			},
		},
	})

	dap.listeners.after.event_initialized["dapui_config"] = function()
		dapui.open()
	end
	dap.listeners.before.event_terminated["dapui_config"] = function()
		dapui.close()
	end
	dap.listeners.before.event_exited["dapui_config"] = function()
		dapui.close()
	end
end

return M
