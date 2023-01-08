local keybind = require("base.keymaps").Keybind.set

keybind { keys = '<leader>u', cmd = vim.cmd.UndotreeToggle, { desc = "[U]ndotree Toggle" } }
