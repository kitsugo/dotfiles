-- Entry point for nvim + global defintions
OS_NAME = vim.loop.os_uname().sysname
DOTFILES_PATH = ""
PLUGINS_MOD = "plugins"
LANGUAGES = {}

-- Setup dotfiles location for either OS
if OS_NAME == "Linux" then
	DOTFILES_PATH = os.getenv("HOME") .. "/"
elseif OS_NAME == "Windows_NT" then
	DOTFILES_PATH = os.getenv("UserProfile") .. "\\windotfiles\\"
end

require("options")
require("keymap")
require("commands")
require("templates")
require("plugin_init")
