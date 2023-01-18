local keymaps = {
  { keys = '<leader>u', cmd = vim.cmd.UndotreeToggle, opts = { desc = "[U]ndotree Toggle" } }
}

BASE.set_keymaps(keymaps)
