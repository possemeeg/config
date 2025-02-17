vim.g.mapleader = " "
vim.g.maplocalleader = " "

vim.keymap.set("n", "<leader>q", ":q<cr>")
vim.keymap.set("n", "<leader>e", ":Ex<cr>")
vim.keymap.set("n", "<leader>w", ":w<cr>")

require("config.lazy")


