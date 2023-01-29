local status_which_key, which_key = pcall(require, "which-key")
if not status_which_key then
  vim.notify("Error from plugins.p_fugitive.keymaps: which-key not found.")
  return
end

which_key.register({
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
