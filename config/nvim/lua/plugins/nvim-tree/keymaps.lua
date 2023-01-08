local keybind = require("base.keymaps").Keybind

keybind("n", "<leader>nt", function() vim.cmd { cmd = "NvimTreeToggle" } end, { desc = "[N]vim[T]ree Toggle" })
