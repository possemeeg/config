vim.g.mapleader = " "
vim.g.maplocalleader = " "
vim.o.background = "dark"

vim.api.nvim_create_user_command('Test', 'echo "It works!"', {nargs="+"})

vim.keymap.set("n", "<leader>q", ":q<cr>")
vim.keymap.set("n", "<leader>e", ":Ex<cr>")
vim.keymap.set("n", "<leader>w", ":w<cr>")
vim.keymap.set("n", "<leader>/", ":noh<cr>")



require("config.lazy")



