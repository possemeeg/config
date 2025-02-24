-- plugins/telescope.lua:
return {
     'nvim-telescope/telescope.nvim',
     tag = '0.1.8',
     dependencies = { 'nvim-lua/plenary.nvim' },
     keys = {
       { "<leader>ff", function() require('telescope.builtin').find_files() end, desc="Find: Files" },
       { "<leader>fg", function() require('telescope.builtin').live_grep() end, desc = 'live grep' },
       { "<leader>fb", function() require('telescope.builtin').buffers() end, desc = 'grep buffers' },
       { "<leader>fh", function() require('telescope.builtin').help_tags() end, desc = 'help tags' },
       { "<leader>fs", function() require('telescope.builtin').grep_string() end, desc = 'grep current word' },
       { "<leader>ft", function() require('telescope.builtin').tags() end, desc = 'tags' },
    },
}
