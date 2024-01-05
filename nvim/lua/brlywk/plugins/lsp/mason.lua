return {
	"williamboman/mason.nvim",
	dependencies = {
		"williamboman/mason-lspconfig.nvim",
	},
	config = function()
		-- import mason
		local mason = require("mason")

		-- import mason-lspconfig
		local mason_lspconfig = require("mason-lspconfig")

		-- enable mason and configure icons
		mason.setup({
			ui = {
				icons = {
					package_installed = "✓",
					package_pending = "➜",
					package_uninstalled = "✗",
				},
				border = "single",
			},
		})

		-- set keymap
		vim.keymap.set("n", "<leader>lm", "<cmd>Mason<CR>", { desc = "Mason" })

		mason_lspconfig.setup({
			-- list of servers for mason to install
			ensure_installed = {
				"astro",
				"cssls",
				"emmet_ls",
				-- "eslint_d",
				"gopls",
				"html",
				-- experimental HTMX support
				-- "htmx-lsp",
				"lua_ls",
				"rust_analyzer",
				"svelte",
				"tailwindcss",
				-- TOML
				"taplo",
				-- Go templating package
				"templ",
				"tsserver",
				"yamlls",
			},
			-- auto-install configured servers (with lspconfig)
			automatic_installation = true, -- not the same as ensure_installed
		})
	end,
}
