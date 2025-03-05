vim.g.mapleader = " "
vim.g.maplocalleader = " "
vim.o.number = true
vim.o.relativenumber = false
-- vim.o.background = "dark"
vim.o.expandtab = true
vim.opt.mouse = ""

vim.api.nvim_create_user_command("Ctags", "!rg --files | ctags -R --links=no -L -", {})

vim.keymap.set("n", "<leader>q", ":q<cr>")
vim.keymap.set("n", "<leader>e", ":Oil<cr>")
vim.keymap.set("n", "<leader>w", ":w<cr>")
vim.keymap.set("n", "<leader>/", ":noh<cr>")
vim.keymap.set("n", "<leader>cd", ":cd %:p:h<CR>:pwd<CR>")
vim.keymap.set("n", "<leader>n", ":set number!<cr>")
vim.keymap.set("n", "<leader>r", ":set relativenumber!<cr>")
vim.keymap.set("n", "<leader>l", ":set background=light<cr>")
vim.keymap.set("n", "<leader>d", ":set background=dark<cr>")

vim.api.nvim_set_hl(0, "DiffAdd", {bg = "#20303b"})
vim.api.nvim_set_hl(0, "DiffDelete", {bg = "#37222c"})
vim.api.nvim_set_hl(0, "DiffChange", {bg = "#1f2231"})
vim.api.nvim_set_hl(0, "DiffText", {bg = "#394b70"})

require("config.lazy")

require("mini.statusline").setup()
vim.cmd[[colorscheme tokyonight-night]]


