-- IMPORTANT: Set mapleader first!
vim.g.mapleader = " "
vim.g.maplocallebder = " "

local k = vim.keymap

-- I can't even remember how often I have entered macro mode accidentally...
k.set("n", "q", "<Nop>", { noremap = true, silent = true })
k.set("n", "<leader>++", function()
	local current_register = vim.fn.reg_executing()

	if current_register == "" then
		local register = vim.fn.input("Register: ")

		if #register == 1 then
			vim.cmd("normal! q" .. register)
		else
			vim.api.nvim_out_write("Invalid register!\n")
		end
	else
		vim.cmd("normal! q")
	end
end, { desc = "Start / stop recording" })

-- shut vim up when pressing space
k.set({ "n", "v" }, "<space>", "<Nop>", { silent = true })

-- better moving lines up and down (move screen lines instead of 'real' lines when lines are wrapped)
k.set("n", "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
k.set("n", "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- buffer movement: set some keymaps (I like the way LazyVim does this)
k.set("n", "H", vim.cmd.bprev)
k.set("n", "L", vim.cmd.bnext)

-- close (delete) all buffers except the currently open ones
k.set("n", "<leader>bQ", "<cmd>%bd|e#|bd#<CR>", { silent = true, desc = "Close all except current" })

-- HANDLED BY MINI.MOVE:
-- In visual mode, alloow J and K to move the selected text up and down
-- k.set('v', '<M-j>', ":m '>+1<CR>gv=gv")
-- k.set('v', '<M-k>', ":m '<-2<CR>gv=gv")

-- keep cursor in the middle of the screen when scrolling by have pages
k.set("n", "<C-d>", "<C-d>zz")
k.set("n", "<C-u>", "<C-u>zz")

-- keep cursor in the middle when searching
k.set("n", "n", "nzzzv")
k.set("n", "N", "Nzzzv")

-- delete single characters to void
k.set("n", "x", '"_x')

-- some convenient INSERT mode commands
k.set("i", "<C-h>", "<Left>")
k.set("i", "<C-l>", "<Right>")
k.set("i", "<C-j>", "<Down>")
k.set("i", "<C-k>", "<Up>")
k.set("i", "<C-b>", "<C-o>_")

-- window management
k.set("n", "<leader>wv", "<C-w>v", { desc = "[W]indow: Split [v]vertically" })
k.set("n", "<leader>wh", "<C-w>s", { desc = "[W]indow: Split [h]orizontaly" })
k.set("n", "<leader>wx", "<cmd>close<CR>", { desc = "[W]indow: Close" })
k.set("n", "<leader>wc", "<cmd>close<CR>", { desc = "[W]indow: Close" })

-- easier movement between windows
k.set("n", "<C-h>", "<C-w>h")
k.set("n", "<C-l>", "<C-w>l")
k.set("n", "<C-j>", "<C-w>j")
k.set("n", "<C-k>", "<C-w>k")

-- pasting from system clipboard (default commands with prefix <leader>)
k.set("n", "<leader>yp", '"+p', { noremap = true, silent = true, desc = "Paste from clipboard" })
k.set("v", "<leader>yp", '"+p', { noremap = true, silent = true, desc = "Paste from clipboard" })
k.set("n", "<leader>yP", '"+P', { noremap = true, silent = true, desc = "Paste from clipboard" })
k.set("v", "<leader>yP", '"+P', { noremap = true, silent = true, desc = "Paste from clipboard" })

-- same for yanking
k.set("n", "<leader>yy", '"+y', { noremap = true, silent = true, desc = "Yank to clipboard" })
k.set("v", "<leader>yy", '"+y', { noremap = true, silent = true, desc = "Yank to clipboard" })

-- open quickfix list
k.set("n", "<leader>ql", vim.cmd.copen, { desc = "Open Quickfix List" })
-- add word under cursor to list for current file
k.set("n", "<leader>qw", function()
	local word = vim.fn.expand("<cword>")
	vim.cmd("vimgrep /\\V\\<" .. word .. "\\>/j %")
end, { desc = "Add word to Quickfix List" })
-- add word under cursor to file for cwd
k.set("n", "<leader>qd", function()
	local word = vim.fn.expand("<cword>")
	vim.cmd("vimgrep /\\V\\<" .. word .. "\\>/j *")
end, { desc = "Add word (cwd) to Quickfix List" })
-- clear quickflix list
k.set("n", "<leader>qx", function()
	vim.fn.setqflist({})
end, { desc = "Clear Quickfix List" })

-- allows replacement of the current word under the cursor
vim.keymap.set(
	"n",
	"<leader>ra",
	[[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]],
	{ desc = "Replace all word occurences" }
)
