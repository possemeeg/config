-- plugins/telescope.lua:
return {
  {
    "nvim-telescope/telescope.nvim",
    dependencies = {
      {
        "nvim-telescope/telescope-live-grep-args.nvim",
      },
    },
    opts = function(_, opts)
      local lga_actions = require("telescope-live-grep-args.actions")
      opts.extensions = {
        live_grep_args = {
          auto_quoting = true, -- enable/disable auto-quoting
          -- define mappings, e.g.
          mappings = { -- extend mappings
          i = {
            ["<C-k>"] = lga_actions.quote_prompt(),
            ["<C-i>"] = lga_actions.quote_prompt({ postfix = " --iglob " }),
          },
        },
        -- ... also accepts theme settings, for example:
        -- theme = "dropdown", -- use dropdown theme
        -- theme = { }, -- use own theme spec
        -- layout_config = { mirror=true }, -- mirror preview pane
      },
    }
  end,
  keys = {
    { "<leader>ff", function() require('telescope.builtin').find_files() end, desc="Find: Files" },
    --{ "<leader>fg", function() require('telescope.builtin').live_grep() end, desc = 'live grep' },
    { "<leader>fb", function() require('telescope.builtin').buffers() end, desc = 'grep buffers' },
    { "<leader>fh", function() require('telescope.builtin').help_tags() end, desc = 'help tags' },
    { "<leader>fs", function() require('telescope.builtin').grep_string() end, desc = 'grep current word' },
    { "<leader>ft", function() require('telescope.builtin').tags() end, desc = 'tags' },
    {
      "<leader>fg",
      "<cmd>lua require('telescope').extensions.live_grep_args.live_grep_args()<CR>",
      desc = "Grep (root dir)",
    },
  },
  config = function(_, opts)
    local tele = require("telescope")
    tele.setup(opts)
    tele.load_extension("live_grep_args")
  end,
},
}
