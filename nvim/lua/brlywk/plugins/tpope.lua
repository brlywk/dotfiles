return {
	-- automatically infer tabwidth and all that crap
	{ "tpope/vim-sleuth" },

	{
		"tpope/vim-fugitive",
		config = function()
			vim.keymap.set("n", "<leader>gs", vim.cmd.Git, { desc = "Git status (fugitive)" })
			vim.keymap.set("n", "<leader>gc", function()
				vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes(":Git ", true, true, true), "n", true)
			end, { desc = "Git command..." })
		end,
	},

	{ "tpope/vim-rhubarb" },
}
