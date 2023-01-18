local Keymaps = require("base.keymaps").Keymaps

local keymaps = {
  { keys = '<leader>u', cmd = vim.cmd.UndotreeToggle, opts = { desc = "[U]ndotree Toggle" } }
}

Keymaps(keymaps)
