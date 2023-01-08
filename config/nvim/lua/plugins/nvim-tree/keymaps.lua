local keybind = require("base.keymaps").Keybind.set

keybind { keys = "<leader>nt", cmd = function() vim.cmd { cmd = "NvimTreeToggle" } end, { desc = "[N]vim[T]ree Toggle" } }
