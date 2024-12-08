-- Entry point for nvim + global defintions
DOTFILES_PATH = ""
PLUGINS_MOD = "plugins"
LANGUAGES = {}
START_DIR = ""
OS_NAME = vim.loop.os_uname().sysname
ARGS = vim.fn.argv()

-- Setup dotfiles location for either OS
if OS_NAME == "Linux" then
	DOTFILES_PATH = os.getenv("HOME") .. "/"
elseif OS_NAME == "Windows_NT" then
	DOTFILES_PATH = os.getenv("UserProfile") .. "\\windotfiles\\"
end

-- Set working directory if started with one
if ARGS[1] ~= nil and ARGS[1]:sub(-#"/") == "/" then
	vim.cmd(":cd %:h")
end

require("options")
require("filetypes")
require("keymap")
require("commands")
require("templates")
require("plugin_init")
