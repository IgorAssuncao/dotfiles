local keybind = require("base.keymaps").Keybind.set

keybind { keys = "<leader>gs", cmd = vim.cmd.Git, opts = { desc = "[G]it [S]tatus" } }
keybind { keys = "<leader>gl", cmd = vim.cmd.GcLog, opts = { desc = "[G]it [L]og" } }
keybind { keys = "<leader>gf", cmd = function() vim.cmd { cmd = "Git!", args = { "fetch" } } end,
  opts = { desc = "[G]it [F]etch" } }
keybind { keys = "<leader>gp", cmd = function() vim.cmd { cmd = "Git!", args = { "push" } } end,
  opts = { desc = "[G]it [P]ush" } }
keybind { keys = "<leader>gP", cmd = function() vim.cmd { cmd = "Git!", args = { "pull" } } end,
  opts = { desc = "[G]it [P]ull" } }
keybind { keys = "<leader>gR", function() vim.cmd { cmd = "Git!", args = { "pull --rebase" } } end,
  opts = { desc = "[G]it [P]ull [R]ebase" } }
keybind { keys = "<leader>gb",
  cmd = function() vim.cmd { cmd = "Git!", args = { "checkout " .. vim.fn.input("Target branch: ") } } end,
  opts = { desc = "[G]it [C]heckout" } }
keybind { keys = "<leader>gc",
  cmd = function() vim.cmd { cmd = "Git!", args = { "checkout -b" .. vim.fn.input("New branch name: ") } } end,
  opts = { desc = "[G]it [C]heckout (create branch)" } }
