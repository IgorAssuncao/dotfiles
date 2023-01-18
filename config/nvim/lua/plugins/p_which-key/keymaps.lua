local keymaps = {
  { keys = "<leader>W", cmd = function() vim.cmd { cmd = "WhichKey" } end, opts = { desc = "[W]hich [K]ey Toggle" } }
}

BASE.set_keymaps(keymaps)
