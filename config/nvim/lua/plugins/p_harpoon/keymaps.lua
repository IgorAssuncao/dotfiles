local status_which_key, which_key = pcall(require, "which-key")
if not status_which_key then
    vim.notify("Error from plugins.p_harpoon.keymaps: which-key not found.")
    return
end

local mark = require('harpoon.mark')
local ui = require('harpoon.ui')

which_key.register({
    h = {
        name = "[H]arpoon",
        a = { mark.add_file, "Mark [a]dd file" },
        m = { ui.toggle_quick_menu, "UI Toggle" }
    }
}, { prefix = "<leader>" })
