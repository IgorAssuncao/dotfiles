local keybind = require("base.keymaps").Keybind.set

keybind { keys = '<leader>u', cmd = vim.cmd.UndotreeToggle, opts = { desc = "[U]ndotree Toggle" } }
