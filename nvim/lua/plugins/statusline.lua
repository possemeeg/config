return {
  "echasnovski/mini.statusline",
  version = "*", -- Uses stable releases to avoid breaking changes on main
  config = function()
    require("mini.statusline").setup({})
  end,
}
