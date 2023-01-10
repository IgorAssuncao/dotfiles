local keybind = require("base.keymaps").Keybind.set

local mark = require('harpoon.mark')
local ui = require('harpoon.ui')

keybind { keys = '<leader>a', cmd = mark.add_file, opts = { desc = "Harpoon mark add file" } }
keybind { keys = '<leader>hm', cmd = ui.toggle_quick_menu, opts = { desc = "Harpoon UI Toggle" } }
