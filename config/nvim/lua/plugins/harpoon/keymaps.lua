local keybind = require("base.keymaps").Keybind.set

local mark = require('harpoon.mark')
local ui = require('harpoon.ui')

keybind { keys = '<leader>a', cmd = mark.add_file, { desc = "Harpoon mark add file" } }
keybind { keys = '<leader>hm', ui.toggle_quick_menu, { desc = "Harpoon UI Toggle" } }
