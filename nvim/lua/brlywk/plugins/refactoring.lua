return {
	{
		"ThePrimeagen/refactoring.nvim",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-treesitter/nvim-treesitter",
		},
		config = function()
			require("refactoring").setup()
		end,
		keys = {
			{
				"<leader>re",
				mode = { "x" },
				function()
					require("refactoring").refactor("Extract Function")
				end,
				desc = "Extract Function",
			},
			{
				"<leader>rf",
				mode = { "x" },
				function()
					require("refactoring").refactor("Extract Function To File")
				end,
				desc = "Extract Function To File",
			},
			{
				"<leader>rv",
				mode = { "x" },
				function()
					require("refactoring").refactor("Extract Variable")
				end,
				desc = "Extract Variable",
			},
			{
				"<leader>rI",
				mode = { "x" },
				function()
					require("refactoring").refactor("Inline Function")
				end,
				desc = "Inline Function",
			},
			{
				"<leader>ri",
				mode = { "x" },
				function()
					require("refactoring").refactor("Inline Variable")
				end,
				desc = "Inline Variable",
			},
			{
				"<leader>rb",
				mode = { "x" },
				function()
					require("refactoring").refactor("Extract Block")
				end,
				desc = "Extract Block",
			},
			{
				"<leader>rB",
				mode = { "x" },
				function()
					require("refactoring").refactor("Extract Block To File")
				end,
				desc = "Extract Block To File",
			},
		},
	},
}
