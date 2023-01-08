local keybind = require("base.keymaps").Keybind.set

keybind { keys = "<leader>gs", cmd = vim.cmd.Git, { desc = "[G]it [S]tatus" } }
keybind { keys = "<leader>gl", cmd = vim.cmd.GcLog, { desc = "[G]it [L]og" } }
keybind { keys = "<leader>gf", cmd = function() vim.cmd { cmd = "Git!", args = { "fetch" } } end,
  { desc = "[G]it [F]etch" } }
keybind { keys = "<leader>gp", cmd = function() vim.cmd { cmd = "Git!", args = { "push" } } end,
  { desc = "[G]it [P]ush" } }
keybind { keys = "<leader>gP", cmd = function() vim.cmd { cmd = "Git!", args = { "pull" } } end,
  { desc = "[G]it [P]ull" } }
keybind { keys = "<leader>gPR", function() vim.cmd { cmd = "Git!", args = { "pull --rebase" } } end,
  { desc = "[G]it [P]ull [R]ebase" } }
keybind { keys = "<leader>gb",
  function() vim.cmd { cmd = "Git!", args = { "checkout " .. vim.fn.input("Target branch: ") } } end,
  { desc = "[G]it [C]heckout" } }
keybind { keys = "<leader>gc",
  function() vim.cmd { cmd = "Git!", args = { "checkout -b" .. vim.fn.input("New branch name: ") } } end,
  { desc = "[G]it [C]heckout (create branch)" } }
