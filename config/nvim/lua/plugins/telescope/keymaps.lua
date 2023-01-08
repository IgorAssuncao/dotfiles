local builtin = require('telescope.builtin')

local keybind = require("base.keymaps").Keybind

keybind('n', '<leader>gf', builtin.git_files, { desc = "[G]it [F]iles" })
keybind('n', '<leader>pf', builtin.find_files, { desc = "[F]ind [F]iles" })
keybind("n", "<leader>ls", builtin.live_grep, { desc = "[L]ive [G]rep" })
keybind("n", "<leader>ps", function()
  builtin.grep_string({ search = "" })
end, { desc = "Find text in project dir" })
keybind('n', '<leader>ss', function()
  builtin.grep_string({ search = vim.fn.input("Grep > ") })
end, { desc = "Find text in project dir with previous grep" })
