return {
	"neovim/nvim-lspconfig",
	event = { "BufReadPre", "BufNewFile" },
	dependencies = {
		"hrsh7th/cmp-nvim-lsp",
		{ "antosha417/nvim-lsp-file-operations", config = true },
	},
	config = function()
		-- globally override floating windows to have a border
		local orig_util_open_floating_preview = vim.lsp.util.open_floating_preview
		function vim.lsp.util.open_floating_preview(contents, syntax, opts, ...)
			opts = opts or {}
			opts.border = "single"
			return orig_util_open_floating_preview(contents, syntax, opts, ...)
		end

		-- import lspconfig plugin
		local lspconfig = require("lspconfig")

		-- import cmp-nvim-lsp plugin
		local cmp_nvim_lsp = require("cmp_nvim_lsp")

		local keymap = vim.keymap
		local opts = { noremap = true, silent = true }

		local on_attach = function(_, bufnr)
			opts.buffer = bufnr

			-- set keybinds
			opts.desc = "Show LSP references"
			keymap.set("n", "gR", "<cmd>Telescope lsp_references<CR>", opts) -- show definition, references

			opts.desc = "Go to declaration"
			keymap.set("n", "gD", vim.lsp.buf.declaration, opts) -- go to declaration

			opts.desc = "Show LSP definitions"
			keymap.set("n", "gd", "<cmd>Telescope lsp_definitions<CR>", opts) -- show lsp definitions

			opts.desc = "Show LSP implementations"
			keymap.set("n", "gi", "<cmd>Telescope lsp_implementations<CR>", opts) -- show lsp implementations

			opts.desc = "Show LSP type definitions"
			keymap.set("n", "gt", "<cmd>Telescope lsp_type_definitions<CR>", opts) -- show lsp type definitions

			opts.desc = "See available code actions"
			keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts) -- see available code actions, in visual mode will apply to selection

			opts.desc = "Smart rename"
			keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts) -- smart rename

			opts.desc = "Show buffer diagnostics"
			keymap.set("n", "<leader>D", "<cmd>Telescope diagnostics bufnr=0<CR>", opts) -- show  diagnostics for file

			opts.desc = "Show line diagnostics"
			keymap.set("n", "<leader>d", vim.diagnostic.open_float, opts) -- show diagnostics for line

			opts.desc = "Go to previous diagnostic"
			keymap.set("n", "[d", vim.diagnostic.goto_prev, opts) -- jump to previous diagnostic in buffer

			opts.desc = "Go to next diagnostic"
			keymap.set("n", "]d", vim.diagnostic.goto_next, opts) -- jump to next diagnostic in buffer

			opts.desc = "Show documentation for what is under cursor"
			keymap.set("n", "K", vim.lsp.buf.hover, opts) -- show documentation for what is under cursor

			opts.desc = "Restart LSP"
			keymap.set("n", "<leader>cR", ":LspRestart<CR>", opts) -- mapping to restart lsp if necessary

			opts.desc = "Organize Imports"
			keymap.set("n", "<leader>ci", ":OrganizeImports<CR>", opts)

			opts.desc = "Format Code"
			keymap.set("n", "<leader>cf", vim.lsp.buf.format, opts)
		end

		-- used to enable autocompletion (assign to every lsp server config)
		local capabilities = cmp_nvim_lsp.default_capabilities()

		-- Change the Diagnostic symbols in the sign column (gutter)
		-- (not in youtube nvim video)
		local signs = { Error = " ", Warn = " ", Hint = "󰠠 ", Info = " " }
		for type, icon in pairs(signs) do
			local hl = "DiagnosticSign" .. type
			vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
		end

		-- Custom function to organize imports for tsserver
		local function organizeImports()
			local params = {
				command = "_typescript.organizeImports",
				arguments = { vim.api.nvim_buf_get_name(0) },
			}
			vim.lsp.buf.execute_command(params)
		end

		-------- LSP SERVER CONFIG -----------------------

		-- HTML
		lspconfig["html"].setup({
			capabilities = capabilities,
			on_attach = on_attach,
		})

		-- TypeScript & Co.
		lspconfig["tsserver"].setup({
			capabilities = capabilities,
			on_attach = on_attach,
			init_options = {
				preferences = {
					disableSuggestions = true,
				},
			},
			commands = {
				OrganizeImports = {
					organizeImports,
					description = "Organize Imports",
				},
			},
		})

		-- CSS
		lspconfig["cssls"].setup({
			capabilities = capabilities,
			on_attach = on_attach,
			-- we need to ignore unknown @rules with tailwind...
			-- there should be a better solution for this though
			settings = {
				css = {
					validate = true,
					lint = {
						unknownAtRules = "ignore",
					},
				},
			},
		})

		-- Tailwind CSS
		lspconfig["tailwindcss"].setup({
			capabilities = capabilities,
			on_attach = on_attach,
		})

		-- Svelte
		lspconfig["svelte"].setup({
			capabilities = capabilities,
			on_attach = on_attach,
		})

		-- Vue
		lspconfig["volar"].setup({
			capabilities = capabilities,
			on_attach = on_attach,
		})


		-- Emmet
		lspconfig["emmet_ls"].setup({
			capabilities = capabilities,
			on_attach = on_attach,
			filetypes = { "html", "typescriptreact", "javascriptreact", "css", "sass", "scss", "less", "svelte" },
		})

		-- Astro
		lspconfig["astro"].setup({
			capabilities = capabilities,
			on_attach = on_attach,
		})

		-- Go
		lspconfig["gopls"].setup({
			capabilities = capabilities,
			on_attach = on_attach,
		})

		-- Rust
		lspconfig["rust_analyzer"].setup({
			capabilities = capabilities,
			on_attach = on_attach,
			settings = {
				["rust-analyzerq"] = {
					checkOnSave = {
						command = "clippy",
					},
				},
			},
		})

		-- TOML
		lspconfig["taplo"].setup({
			capabilities = capabilities,
			on_attach = on_attach,
		})

		-- YAML
		lspconfig["yamlls"].setup({
			capabilities = capabilities,
			on_attach = on_attach,
		})

		-- HTMX
		lspconfig["htmx"].setup({
			capabilities = capabilities,
			on_attach = on_attach,
		})

		-- Templ (Go Templating Package)
		lspconfig["templ"].setup({
			capabilities = capabilities,
			on_attach = on_attach,
		})

		-- Lua server (with special settings)
		lspconfig["lua_ls"].setup({
			capabilities = capabilities,
			on_attach = on_attach,
			settings = { -- custom settings for lua
				Lua = {
					-- make the language server recognize "vim" global
					diagnostics = {
						globals = { "vim" },
					},
					workspace = {
						-- make language server aware of runtime files
						library = {
							[vim.fn.expand("$VIMRUNTIME/lua")] = true,
							[vim.fn.stdpath("config") .. "/lua"] = true,
						},
					},
				},
			},
		})

		-- currently unused

		-- Python
		-- lspconfig["pyright"].setup({
		-- 	capabilities = capabilities,
		-- 	on_attach = on_attach,
		-- })

		-- -- Prism
		-- lspconfig["prismals"].setup({
		-- 	capabilities = capabilities,
		-- 	on_attach = on_attach,
		-- })

		-- GraphQL
		-- lspconfig["graphql"].setup({
		-- 	capabilities = capabilities,
		-- 	on_attach = on_attach,
		-- 	filetypes = { "graphql", "gql", "svelte", "typescriptreact", "javascriptreact" },
		-- })
	end,
}
