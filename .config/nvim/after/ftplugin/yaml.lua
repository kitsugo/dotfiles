local utils = require("utils")

local is_ansible_project = utils.has_local_config(vim.fn.expand("%"), { "ansible.cfg" })
if is_ansible_project then
	vim.cmd("set filetype=yaml.ansible")
end
