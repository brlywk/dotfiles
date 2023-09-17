return {
	{
		"NvChad/nvterm",
		config = function()
			require("nvterm").setup()

			-- keymaps
			-- open floating terminal
			vim.keymap.set("n", "<A-f>", function()
				require("nvterm.terminal").toggle("float")
			end, {})
			vim.keymap.set("n", "<A-v>", function()
				require("nvterm.terminal").toggle("vertical")
			end, {})
			vim.keymap.set("n", "<A-H>", function()
				require("nvterm.terminal").toggle("horizontal")
			end, {})
			-- close floating terminal
			vim.keymap.set("t", "<A-f>", function()
				require("nvterm.terminal").toggle("float")
			end, {})
			vim.keymap.set("t", "<A-H>", function()
				require("nvterm.terminal").toggle("vertical")
			end, {})
			vim.keymap.set("t", "<A-h>", function()
				require("nvterm.terminal").toggle("horizontal")
			end, {})
		end,
	},
}
