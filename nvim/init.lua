vim.g.mapleader = " "
vim.g.maplocalleader = " "
-- vim.o.background = "dark"
vim.o.expandtab = true

vim.api.nvim_create_user_command('Test', 'echo "It works!"', {nargs="+"})

vim.keymap.set("n", "<leader>q", ":q<cr>")
vim.keymap.set("n", "<leader>e", ":Ex<cr>")
vim.keymap.set("n", "<leader>w", ":w<cr>")
vim.keymap.set("n", "<leader>/", ":noh<cr>")
vim.keymap.set("n", "<leader>cd", ":cd %:p:h<CR>:pwd<CR>")

vim.api.nvim_set_hl(0, "DiffAdd", {bg = "#20303b"})
vim.api.nvim_set_hl(0, "DiffDelete", {bg = "#37222c"})
vim.api.nvim_set_hl(0, "DiffChange", {bg = "#1f2231"})
vim.api.nvim_set_hl(0, "DiffText", {bg = "#394b70"})

require("config.lazy")

vim.cmd[[colorscheme tokyonight]]


