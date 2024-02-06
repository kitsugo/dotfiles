local M = {}

-- Checks whether a given program is executable/installed on this machine
function M.is_installed(program)
	if vim.fn.executable(program) == 1 then
		return true
	end
	return false
end

function M.num_to_bool(num)
	if num == 1 then
		return true
	end
	return false
end

return M
