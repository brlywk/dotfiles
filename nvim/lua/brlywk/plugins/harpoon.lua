return {
    'ThePrimeagen/harpoon',
    config = function()
        vim.keymap.set ( 'n', "<space>ha", require("harpoon.mark").add_file, { desc = '[H]arpoon: [a]dd file' })
        vim.keymap.set ( 'n', "<space>ht", require("harpoon.ui").toggle_quick_menu, { desc = '[H]arpoon: [t]oggle' } )

        -- space 1 - 5 to quickly jump between files
        for i = 1, 5 do
            local key = string.format("<space>%s", i)
            local desc = string.format("Harpoon Window %s", i)
            vim.api.nvim_set_keymap('n', key, string.format(":lua require('harpoon.ui').nav_file(%s)<CR>", i), { noremap = true, silent = true, desc = desc })
        end
    end,
}

