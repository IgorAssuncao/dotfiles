return {
    "theprimeagen/harpoon",
    -- TODO: Load this plugin on keymap.
    -- lazy = true,
    -- keys = {
    --   { "<leader>h", "", desc = "[H]arpoon" }
    -- },
    event = "VeryLazy",
    config = function()
        local mark = require('harpoon.mark')
        local ui = require('harpoon.ui')

        require("which-key").register({
            h = {
                name = "[H]arpoon",
                a = { mark.add_file, "Mark [a]dd file" },
                m = { ui.toggle_quick_menu, "UI Toggle" }
            }
        }, { prefix = "<leader>" })
    end
}
