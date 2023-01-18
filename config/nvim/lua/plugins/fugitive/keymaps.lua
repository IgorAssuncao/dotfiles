local Keymaps = require("base.keymaps").Keymaps

local keymaps = {
  { keys = "<leader>gs", cmd = vim.cmd.Git, opts = { desc = "[G]it [S]tatus" } },
  { keys = "<leader>gl", cmd = vim.cmd.GcLog, opts = { desc = "[G]it [L]og" } },
  { keys = "<leader>gf", cmd = function() vim.cmd { cmd = "Git!", args = { "fetch" } } end,
    opts = { desc = "[G]it [F]etch" } },
  { keys = "<leader>gs", cmd = vim.cmd.Git, opts = { desc = "[G]it [S]tatus" } },
  { keys = "<leader>gl", cmd = vim.cmd.GcLog, opts = { desc = "[G]it [L]og" } },
  { keys = "<leader>gf", cmd = function() vim.cmd { cmd = "Git!", args = { "fetch" } } end,
  opts = { desc = "[G]it [F]etch" } },
  { keys = "<leader>gp", cmd = function() vim.cmd { cmd = "Git!", args = { "push" } } end,
  opts = { desc = "[G]it [P]ush" } },
  { keys = "<leader>gPP", cmd = function() vim.cmd { cmd = "Git", args = { "pull" } } end,
  opts = { desc = "[G]it [P]ull" } },
  { keys = "<leader>gPR", function() vim.cmd { cmd = "echo", args = { '"pull --rebase"' } } end,
  opts = { desc = "[G]it [P]ull [R]ebase" } },
  { keys = "<leader>gb",
  cmd = function() vim.cmd { cmd = "Git!", args = { "checkout " .. vim.fn.input("Target branch: ") } } end,
  opts = { desc = "[G]it [C]heckout" } },
  { keys = "<leader>gc",
  cmd = function() vim.cmd { cmd = "Git!", args = { "checkout -b" .. vim.fn.input("New branch name: ") } } end,
  opts = { desc = "[G]it [C]heckout (create branch)" } },

}

Keymaps(keymaps)
