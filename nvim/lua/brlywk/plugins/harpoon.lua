return {
	"ThePrimeagen/harpoon",
	branch = "harpoon2",
	dependencies = { "nvim-lua/plenary.nvim" },
	config = function()
		local harpoon = require("harpoon")
		harpoon:setup({
			settings = {
				save_on_toggle = true,
				sync_on_ui_close = true,
			},
		})

		-- add to list
		vim.keymap.set("n", "<space>a", function()
			harpoon:list():append()
		end, { desc = "Harpoon: Add File" })
		-- show overview
		vim.keymap.set("n", "<space>bm", function()
			harpoon.ui:toggle_quick_menu(harpoon:list())
		end, { desc = "Harpoon: Quick Menu" })
		-- next
		vim.keymap.set("n", "<space>bn", function()
			harpoon:list():next()
		end, { desc = "Harpoon: Next" })
		-- prev
		vim.keymap.set("n", "<space>bN", function()
			harpoon:list():prev()
		end, { desc = "Harpoon: Previous" })

		-- space 1 - 5 to quickly jump between files
		for i = 1, 5 do
			local key = string.format("<space>%s", i)
			local desc = string.format("Harpoon: Buffer %s", i)
			vim.api.nvim_set_keymap(
				"n",
				key,
				string.format(":lua require('harpoon'):list():select(%s)<CR>", i),
				{ noremap = true, silent = true, desc = desc }
			)
		end
	end,
}

-- Good ol' harpoon v1
-- return {
-- 	"ThePrimeagen/harpoon",
-- 	config = function()
-- 		vim.keymap.set("n", "<space>ba", require("harpoon.mark").add_file, { desc = "Harpoon: Add File" })
-- 		vim.keymap.set("n", "<space>bt", require("harpoon.ui").toggle_quick_menu, { desc = "Harpoon: Quick Menu" })
-- 		vim.keymap.set("n", "<space>bn", require("harpoon.ui").nav_next, { desc = "Harpoon: Next" })
-- 		vim.keymap.set("n", "<space>bN", require("harpoon.ui").nav_prev, { desc = "Harpoon: Previous" })
--
-- 		-- space 1 - 5 to quickly jump between files
-- 		for i = 1, 5 do
-- 			local key = string.format("<space>%s", i)
-- 			local desc = string.format("Harpoon: Window %s", i)
-- 			vim.api.nvim_set_keymap(
-- 				"n",
-- 				key,
-- 				string.format(":lua require('harpoon.ui').nav_file(%s)<CR>", i),
-- 				{ noremap = true, silent = true, desc = desc }
-- 			)
-- 		end
-- 	end,
-- }
