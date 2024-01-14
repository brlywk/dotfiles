return {
	"stevearc/conform.nvim",
	event = { "BufReadPre", "BufNewFile" },
	config = function()
		require("conform").setup({
			-- configure which formatter to use
			formatters_by_ft = {
				html = { "prettierd", "prettier" },
				css = { "prettierd", "prettier" },
				scss = { "prettierd", "prettier" },

				javascript = { "prettierd", "prettier" },
				typescript = { "prettierd", "prettier" },
				javascriptreact = { "prettierd", "prettier" },
				typescriptreact = { "prettierd", "prettier" },

				astro = { "prettierd", "prettier" },
				svelte = { "prettierd", "prettier" },
				vue = { "prettierd", "prettier" },

				json = { "prettierd", "prettier" },
				markdown = { "prettierd", "prettier" },
				yaml = { "yamlfix" },
				toml = { "taplo" },
				lua = { "stylua" },

				go = { "gofumpt" },
				rust = { "rustfmt" },
				python = { "blue" },
			},
			format_on_save = {
				timeout_ms = 500,
				lsp_fallback = true,
			},
		})

		-- keymap to trigger formatting manually
		vim.keymap.set({ "n", "v" }, "<leader>cf", function()
			--- @diagnostic disable-next-line:undefined-global
			conform.format({
				lsp_fallback = true,
				async = false,
				timeout_ms = 500,
			})
		end, { desc = "Format file or range (visual mode)" })
	end,
}
