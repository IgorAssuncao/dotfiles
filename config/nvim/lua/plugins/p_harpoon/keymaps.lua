local mark = require('harpoon.mark')
local ui = require('harpoon.ui')

-- local keymaps = {
--   { keys = '<leader>a', cmd = mark.add_file, opts = { desc = "Harpoon mark add file" } },
--   { keys = '<leader>hm', cmd = ui.toggle_quick_menu, opts = { desc = "Harpoon UI Toggle" } }
-- }
--
-- Keymaps(keymaps)

PLUGINS.which_key.register({
  h = {
    name = "[H]arpoon",
    a = { mark.add_file, "Mark [a]dd file" },
    m = { ui.toggle_quick_menu, "UI Toggle" }
  }
}, { prefix = "<leader>" })
