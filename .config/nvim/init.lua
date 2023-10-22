OS_NAME = vim.loop.os_uname().sysname
DOTFILES = ""
LANGUAGES = {}

if OS_NAME == "Linux" then
	DOTFILES = os.getenv("HOME") .. "/"
elseif OS_NAME == "Windows_NT" then
	DOTFILES = os.getenv("UserProfile") .. "\\windotfiles\\"
end

require("options")
require("keymap")
require("commands")
require("templates")
require("lazy_plugins")
