local M = {}

-- Remove all empty "No Name" buffers that are unmodified
function M.clean_empty_bufs()
	for _, buf in pairs(vim.api.nvim_list_bufs()) do
		if
			vim.api.nvim_buf_get_name(buf) == ""
			and not vim.api.nvim_buf_get_option(buf, "modified")
			and vim.api.nvim_buf_is_loaded(buf)
		then
			vim.api.nvim_buf_delete(buf, {})
		end
	end
end

-- Checks whether a given program is executable/installed on this machine
function M.is_installed(program)
	if vim.fn.executable(program) == 1 then
		return true
	end
	return false
end

-- Check whether a local formatter/linter configuration file is present in the same directory or upward of a given file
function M.has_local_config(location, config_names)
	local has = false
	for i in pairs(config_names) do
		local found = vim.fs.find(config_names[i], { upward = true, location })
		if not (next(found) == nil) then
			has = true
			break
		end
	end
	return has
end

function M.is_git_project(location)
	local found = vim.fs.find(".git", { upward = true, location })
	if not (next(found) == nil) then
		return true
	else
		return false
	end
end

function M.num_to_bool(num)
	if num == 1 then
		return true
	end
	return false
end

function M.is_table(obj)
	return type(obj) == "table"
end

function M.dump_table(o)
	if type(o) == "table" then
		local s = "{ "
		for k, v in pairs(o) do
			if type(k) ~= "number" then
				k = '"' .. k .. '"'
			end
			s = s .. "[" .. k .. "] = " .. M.dump_table(v) .. ","
		end
		return s .. "} "
	else
		return tostring(o)
	end
end

function M.append_inplace(t1, t2)
  for i = 1, #t2 do
    t1[#t1 + 1] = t2[i]
  end
  return t1
end

return M
