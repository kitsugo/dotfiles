local capabilities = require("cmp_nvim_lsp").default_capabilities(vim.lsp.protocol.make_client_capabilities())
local root_dir = vim.fs.dirname(vim.fs.find({ ".gradlew", ".git", "mvnw", "build.sh" }, { upward = true })[1])
local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ":p:h:t")
local local_libs = {}
if root_dir then
	local_libs = vim.split(vim.fn.glob(root_dir .. "/lib/*.jar"), "\n")
end

local config = {
	settings = {
		java = {
			format = {
				settings = {
					url = vim.fn.stdpath("config") .. "/configs/.java_style.xml",
				},
			},
			-- For full java docs a jdk-sources package might need to be installed
			signatureHelp = { enabled = true },
			contentProvider = { preferred = "fernflower" },
			eclipse = {
				downloadSources = true,
			},
			completion = {
				filteredTypes = {
					"com.sun.*",
					"io.micrometer.shaded.*",
					"java.awt.*",
					"jdk.*",
					"sun.*",
				},
			},
			sources = {
				organizeImports = {
					starThreshold = 9999,
					staticStarThreshold = 9999,
				},
			},
			saveActions = {
				organizeImports = true,
			},
			-- Fallback to a project-specific JAR library in case the project is not built with gradle/maven
			-- Requires that .classpath and .project files are deleted for the referencedLibraries to be sourced
			project = {
				referencedLibraries = local_libs,
			},
		},
	},
	root_dir = root_dir,
	capabilities = capabilities,
}

if OS_NAME == "Linux" then
	local home = os.getenv("HOME")
	local workspace_dir = home .. "/.local/eclipse/" .. project_name
	local bundles = { vim.fn.glob(home .. "/.local/share/nvim/com.microsoft.java.debug.plugin-*.jar", 1) }
	vim.list_extend(bundles, vim.split(vim.fn.glob(home .. "/.local/share/nvim/server/*.jar", 1), "\n"))

	config.cmd = {
		"java",
		"-Declipse.application=org.eclipse.jdt.ls.core.id1",
		"-Dosgi.bundles.defaultStartLevel=4",
		"-Declipse.product=org.eclipse.jdt.ls.core.product",
		"-Dlog.protocol=true",
		"-Dlog.level=ALL",
		"-Xms1g",
		"--add-modules=ALL-SYSTEM",
		"--add-opens",
		"java.base/java.util=ALL-UNNAMED",
		"-jar",
		home
			.. "/.local/share/nvim/mason/packages/jdtls/plugins/org.eclipse.equinox.launcher_1.6.400.v20210924-0641.jar",
		"-configuration",
		home .. "/.local/share/nvim/mason/packages/jdtls/config_linux/",
		"-data",
		workspace_dir,
	}
	config.settings.java.configuration = {
		runtimes = {
			{
				name = "JavaSE-17",
				path = "/usr/lib/jvm/java-17-openjdk/",
			},
			{
				name = "JavaSE-20",
				path = "/usr/lib/jvm/java-21-openjdk/",
			},
		},
	}
	config.init_options = {
		bundles = bundles,
	}
elseif OS_NAME == "Windows_NT" then
	local home = os.getenv("UserProfile")

	config.cmd = {
		"java",
		"-Declipse.application=org.eclipse.jdt.ls.core.id1",
		"-Dosgi.bundles.defaultStartLevel=4",
		"-Declipse.product=org.eclipse.jdt.ls.core.product",
		"-Dlog.protocol=true",
		"-Dlog.level=ALL",
		"-Xms1g",
		"--add-modules=ALL-SYSTEM",
		"--add-opens",
		"java.base/java.util=ALL-UNNAMED",
		"-jar",
		home
			.. "/AppData/Local/nvim-data/mason/packages/jdtls/plugins/org.eclipse.equinox.launcher_1.6.400.v20210924-0641.jar",
		"-configuration",
		home .. "/AppData/Local/nvim-data/mason/packages/jdtls/config_win",
		"-data",
		home .. "/.jdtls/workspace",
	}
end

return config
