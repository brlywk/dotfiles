return {
	"ThePrimeagen/harpoon",
	config = function()
		vim.keymap.set("n", "<space>ba", require("harpoon.mark").add_file, { desc = "Harpoon: Add File" })
		vim.keymap.set("n", "<space>bt", require("harpoon.ui").toggle_quick_menu, { desc = "Harpoon: Quick Menu" })
		vim.keymap.set("n", "<space>bn", require("harpoon.ui").nav_next, { desc = "Harpoon: Next" })
		vim.keymap.set("n", "<space>bN", require("harpoon.ui").nav_prev, { desc = "Harpoon: Previous" })

		-- space 1 - 5 to quickly jump between files
		for i = 1, 5 do
			local key = string.format("<space>%s", i)
			local desc = string.format("Harpoon: Window %s", i)
			vim.api.nvim_set_keymap(
				"n",
				key,
				string.format(":lua require('harpoon.ui').nav_file(%s)<CR>", i),
				{ noremap = true, silent = true, desc = desc }
			)
		end
	end,
}
