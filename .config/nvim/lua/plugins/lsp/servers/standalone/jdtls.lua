-- JDTLS is the most-feature complete language server for Java available in nvim.
-- Because of its complex setup, it is not setup as part of "nvim-lspconfig", but as a standalone server.
-- Refer to "https://github.com/mfussenegger/nvim-jdtls" for help.

-- Detect Java project
local project_root_dir =
	vim.fs.dirname(vim.fs.find({ ".git", ".gradlew", "pom.xml", ".classpath", ".project" }, { upward = true })[1])
local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ":p:h:t")

-- Find project-specific libraries situated inside "/lib"
-- This is only needed for pure eclipse (not maven/gradle) projects
local project_libs = {}
if project_root_dir then
	project_libs = vim.split(vim.fn.glob(project_root_dir .. "/lib/*.jar"), "\n")
end

local jdtls_config = {
	settings = {
		java = {
			-- Java default formatting style
			format = {
				settings = {
					url = vim.fn.stdpath("config") .. "/configs/.java_style.xml",
				},
			},
			-- For full Java docs a jdk-sources package might need to be installed
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
				referencedLibraries = project_libs,
			},
		},
	},
	root_dir = project_root_dir,
	capabilities = require("cmp_nvim_lsp").default_capabilities(vim.lsp.protocol.make_client_capabilities()),
}

--
-- LINUX SETUP
--
if OS_NAME == "Linux" then
	-- Find Java runtimes on Linux
	local java_runtimes = vim.fn.glob("/usr/lib/jvm/java-*-openjdk/", true, true)
	local available_runtimes = {}
	for _, runtime in ipairs(java_runtimes) do
		-- Match only compatible runtimes: >= JDK 21
		local version = string.match(runtime, "[2-9][1-9]")
		if version then
			table.insert(available_runtimes, {
				name = "JavaSE-" .. version,
				path = runtime,
			})
		end
	end
	if next(available_runtimes) == nil then
		print("No JDK compatible with JDTLS detected! Please install any JDK >=21")
		return {}
	end

	local home = os.getenv("HOME")
	local workspace_dir = "/tmp/java/" .. project_name
	local bundles = { vim.fn.glob(home .. "/.local/share/nvim/com.microsoft.java.debug.plugin-*.jar", true) }

	vim.list_extend(bundles, vim.split(vim.fn.glob(home .. "/.local/share/nvim/server/*.jar", true), "\n"))
	jdtls_config.cmd = {
		available_runtimes[1].path .. "/bin/java",
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
		vim.fn.glob(home .. "/.local/share/nvim/mason/packages/jdtls/plugins/org.eclipse.equinox.launcher_*.jar"),
		"-configuration",
		home .. "/.local/share/nvim/mason/packages/jdtls/config_linux/",
		"-data",
		workspace_dir,
	}
	jdtls_config.settings.java.configuration = {
		-- Find all installed runtimes on Linux
		runtimes = available_runtimes,
	}
	jdtls_config.init_options = {
		bundles = bundles,
	}

--
-- WINDOWS SETUP
--
elseif OS_NAME == "Windows_NT" then
	local home = os.getenv("UserProfile")
	jdtls_config.cmd = {
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
		vim.fn.glob(home .. "/AppData/Local/nvim-data/mason/packages/jdtls/plugins/org.eclipse.equinox.launcher_*.jar"),
		"-configuration",
		home .. "/AppData/Local/nvim-data/mason/packages/jdtls/config_win",
		"-data",
		home .. "/.jdtls/workspace",
	}
end

return jdtls_config
