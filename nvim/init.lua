vim.g.mapleader = " "
vim.g.maplocalleader = " "
vim.g.python3_host_prog = "/home/peter/.venv/nvim/bin/python3"
vim.o.number = true
vim.o.relativenumber = true
-- vim.o.background = "dark"
vim.o.expandtab = true
vim.o.cursorline = true
vim.opt.mouse = ""

vim.g.clipboard = {
  name =  "myClipboard",
  copy = {
    ["+"] = "xclip -selection clipboard",
    ["*"] = "xclip -selection primary",
  },
  paste = {
    ["+"] = "xclip -selection clipboard -o",
    ["*"] = "xclip -selection primary -o",
  },
  cache_enabled = 1,
}

vim.api.nvim_create_user_command("Ctags", "!rg --files | ctags -R --links=no -L -", {})

vim.keymap.set("n", "<leader>qw", ":q<cr>")
vim.keymap.set('n', '<leader>bd', ':bdelete<CR>', { desc = 'Delete buffer' })
vim.keymap.set('n', '<leader>qa', ':qa<CR>', { desc = 'Quit all' })
vim.keymap.set("n", "<leader>e", ":Oil<cr>")
vim.keymap.set("n", "<leader>w", ":w<cr>")
vim.keymap.set("n", "<leader>/", ":noh<cr>")
vim.keymap.set("n", "<leader>cd", ":cd %:p:h<CR>:pwd<CR>")
vim.keymap.set("n", "<leader>n", ":set number!<cr>")
vim.keymap.set("n", "<leader>r", ":set relativenumber!<cr>")
vim.keymap.set("n", "<leader>l", ":set background=light<cr>")
vim.keymap.set("n", "<leader>d", ":set background=dark<cr>")
vim.keymap.set("n", "<leader>F", ":Neoformat<cr>")
vim.keymap.set("n", "<leader>bc", ":let @b=bufnr(@%)<cr>")
vim.keymap.set("n", "<leader>bp", ":exe('b'.@b)<cr>")
vim.keymap.set("n", "<leader>tn", ":tabnew<cr>")

vim.api.nvim_set_hl(0, "DiffAdd", {bg = "#20303b"})
vim.api.nvim_set_hl(0, "DiffDelete", {bg = "#37222c"})
vim.api.nvim_set_hl(0, "DiffChange", {bg = "#1f2231"})
vim.api.nvim_set_hl(0, "DiffText", {bg = "#394b70"})

require("config.lazy")

require("mini.statusline").setup()
vim.cmd[[colorscheme tokyonight-night]]

vim.api.nvim_create_user_command('Bdh', function ()
  local bufinfos = vim.fn.getbufinfo({buflisted = true})
  vim.tbl_map(function (bufinfo)
    if bufinfo.changed == 0 and (not bufinfo.windows or #bufinfo.windows == 0) then
      print(('Deleting buffer %d : %s'):format(bufinfo.bufnr, bufinfo.name))
      vim.api.nvim_buf_delete(bufinfo.bufnr, {force = false, unload = false})
    end
  end, bufinfos)
end, { desc = 'Wipeout all buffers not shown in a window'})

vim.keymap.set('n', '<leader>y', function()
  if vim.opt.clipboard:get()[1] == 'unnamedplus' then
    vim.opt.clipboard = ''
    vim.notify('Clipboard: Default (Neovim standard registers)', vim.log.levels.INFO)
  else
    vim.opt.clipboard = 'unnamedplus'
    vim.notify('Clipboard: System (unnamedplus)', vim.log.levels.INFO)
  end
end, { desc = 'Toggle system clipboard' })

vim.keymap.set('n', '<leader>qp', function()
  -- Read clipboard content ('+' or '*' register)
  local clipboard_content = vim.fn.getreg('+')

  -- Split clipboard string by newlines into a list of lines
  local lines = vim.split(clipboard_content, '\n', { plain = true })

  -- Populate the quickfix list
  vim.fn.setqflist({}, 'r', {
    title = 'Clipboard',
    lines = lines,
  })

  -- Open the quickfix window
  vim.cmd('cope')
end, { desc = 'Dump clipboard to quickfix and open' })

os.execute("echo hello")

