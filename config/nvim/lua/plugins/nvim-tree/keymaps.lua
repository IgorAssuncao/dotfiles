local keybind = require("base.keymaps").Keybind.set

keybind { keys = "<leader>nt", cmd = function() vim.cmd { cmd = "NvimTreeToggle" } end,
  opts = { desc = "[N]vim[T]ree Toggle" } }
keybind { keys = "<leader>nf", cmd = function() vim.cmd { cmd = "NvimTreeFindFile" } end,
  opts = { desc = "[N]vim[T]ree Find File" } }
