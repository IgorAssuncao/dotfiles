local Keymaps = require("base.keymaps").Keymaps

local mark = require('harpoon.mark')
local ui = require('harpoon.ui')

local keymaps = {
  { keys = '<leader>a', cmd = mark.add_file, opts = { desc = "Harpoon mark add file" } },
  { keys = '<leader>hm', cmd = ui.toggle_quick_menu, opts = { desc = "Harpoon UI Toggle" } }
}

Keymaps(keymaps)
