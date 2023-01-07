vim.keymap.set("n", "<leader>gs", vim.cmd.Git)
vim.keymap.set("n", "<leader>gl", vim.cmd.GcLog)
vim.keymap.set("n", "<leader>gf", function() vim.cmd { cmd = "Git!", args = { "fetch" } } end)
vim.keymap.set("n", "<leader>gp", function() vim.cmd { cmd = "Git!", args = { "push" } } end)
vim.keymap.set("n", "<leader>gP", function() vim.cmd { cmd = "Git!", args = { "pull" } } end)
vim.keymap.set("n", "<leader>gPR", function() vim.cmd { cmd = "Git!", args = { "pull --rebase" } } end)
vim.keymap.set("n", "<leader>gb",
  function() vim.cmd { cmd = "Git!", args = { "checkout " .. vim.fn.input("Target branch: ") } } end)
vim.keymap.set("n", "<leader>gc",
  function() vim.cmd { cmd = "Git!", args = { "checkout -b" .. vim.fn.input("New branch name: ") } } end)
