local builtin = require("telescope.builtin")

local keybind = require("base.keymaps").Keybind.set

keybind { keys = "<leader>gf", cmd = builtin.git_files, opts = { desc = "[G]it [F]iles" } }
keybind { keys = "<leader>pf", cmd = builtin.find_files, opts = { desc = "[F]ind [F]iles" } }
keybind { keys = "<leader>ls", cmd = builtin.live_grep, opts = { desc = "[L]ive [G]rep" } }
keybind { keys = "<leader>ps", cmd = function()
  builtin.grep_string({ search = "" })
end, opts = { desc = "Find text in project dir" } }
keybind { keys = "<leader>ss", cmd = function()
  builtin.grep_string({ search = vim.fn.input("Grep > ") })
end, opts = { desc = "Find text in project dir with previous grep" } }
