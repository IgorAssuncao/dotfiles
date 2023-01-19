--local keymaps = {
--  { keys = "<leader>gs", cmd = vim.cmd.Git, opts = { desc = "[G]it [S]tatus" } },
--  { keys = "<leader>gl", cmd = vim.cmd.GcLog, opts = { desc = "[G]it [L]og" } },
--  { keys = "<leader>gf", cmd = function() vim.cmd { cmd = "Git!", args = { "fetch" } } end,
--    opts = { desc = "[G]it [F]etch" } },
--  { keys = "<leader>gp", cmd = function() vim.cmd { cmd = "Git!", args = { "push" } } end,
--    opts = { desc = "[G]it [P]ush" } },
--  { keys = "<leader>gPP", cmd = function() vim.cmd { cmd = "Git", args = { "pull" } } end,
--    opts = { desc = "[G]it [P]ull" } },
--  { keys = "<leader>gPR", function() vim.cmd { cmd = "echo", args = { '"pull --rebase"' } } end,
--    opts = { desc = "[G]it [P]ull [R]ebase" } },
--  { keys = "<leader>gb",
--    cmd = function() vim.cmd { cmd = "Git!", args = { "checkout " .. vim.fn.input("Target branch: ") } } end,
--    opts = { desc = "[G]it [C]heckout" } },
--  { keys = "<leader>gc",
--    cmd = function() vim.cmd { cmd = "Git!", args = { "checkout -b" .. vim.fn.input("New branch name: ") } } end,
--    opts = { desc = "[G]it [C]heckout (create branch)" } }
--}
--
--BASE.set_keymaps(keymaps)

PLUGINS.which_key.register({
  g = {
    name = "[G]it",
    s = { vim.cmd.Git, "[S]tatus" },
    l = { vim.cmd.GcLog, "[L]og" },
    f = { function() vim.cmd.Git { args = "fetch" } end, "[F]etch" },
    b = { function() vim.cmd.Git { args = { "branch" } } end, "[B]ranch" },
    c = {
      name = "Checkout",
      b = { function() vim.cmd.Git { args = { "switch " .. vim.fn.input("Target branch: ") } } end,
        "[S]witch to existing branch" },
      c = { function() vim.cmd.Git { args = { "switch -c " .. vim.fn.input("Create branch: ") } } end,
        "[C]reate branch" },
    },
    p = { function() vim.cmd.Git { args = { "push" } } end, "[P]ush" },
    P = {
      name = "Pull Options",
      P = { function() vim.cmd { cmd = "Git", args = { "pull" } } end, "Default" },
      R = { function() vim.cmd { cmd = "Git", args = { "pull --rebase" } } end, "[R]ebasing" }
    },
  }
}, { prefix = "<leader>" })
