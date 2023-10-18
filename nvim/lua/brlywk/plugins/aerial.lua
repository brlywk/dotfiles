return {
	"stevearc/aerial.nvim",
	opts = {},
	config = function()
		require("aerial").setup({
			layout = {
				min_width = 20,
			},
		})
	end,
	dependencies = {
		"nvim-treesitter/nvim-treesitter",
		"nvim-tree/nvim-web-devicons",
	},
	keys = {
		{
			"<leader>co",
			"<cmd>AerialToggle!<CR>",
			desc = "Code Outline (Aerial)",
		},
	},
}
