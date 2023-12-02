return {
	"stevearc/oil.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	opts = {},
	config = function()
		require("oil").setup({
			default_file_explorer = true,
			skip_confirm_for_simple_edits = true,
			delete_to_trash = "true",

			keymap = {
				["'"] = "actions.parent",
			},
			view_options = {
				show_hidden = false,
			},
		})

		vim.keymap.set(
			"n",
			"<leader>fe",
			":Oil --float<CR>",
			{ noremap = true, silent = true, desc = "File Explorer (Oil)" }
		)
	end,
}
