local Keymaps = require("base.keymaps").Keymaps

local keymaps = {
  { keys = "<leader>nt", cmd = function() vim.cmd { cmd = "NvimTreeToggle" } end,
    opts = { desc = "[N]vim[T]ree Toggle" } },
  { keys = "<leader>nf", cmd = function() vim.cmd { cmd = "NvimTreeFindFile" } end,
    opts = { desc = "[N]vim[T]ree Find File" } }
}

Keymaps(keymaps)
