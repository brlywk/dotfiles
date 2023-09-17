return {
	{
		"nvim-neo-tree/neo-tree.nvim",
		lazy = false,
		branch = "v3.x",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-tree/nvim-web-devicons",
			"MunifTanjim/nui.nvim",
		},
		keys = {
			{
				"<C-e>",
				function()
					require("neo-tree.command").execute({
						toggle = true,
						reveal_force_cwd = true,
						position = "float",
					})
				end,
				desc = "Open File Tree",
			},
			{
				"<leader>fe",
				function()
					require("neo-tree.command").execute({
						toggle = true,
						reveal_force_cwd = true,
						position = "float",
					})
				end,
				desc = "Open File Tree",
			},
		},
		opts = {
			disable_netrw = true,
			hijack_netrw = true,
			popup_border_style = "single",
			enable_git_status = true,
			enable_diagnostics = true,
			window = {
				position = "float",
				mappings = {
					["<space>"] = "none",
				},
			},
			filesystem = {
				hijack_netrw_behavior = "open_default",
			},
		},
	},
}
