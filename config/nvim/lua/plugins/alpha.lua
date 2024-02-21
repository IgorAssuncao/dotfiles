-- Plugin that allows a nicer startup menu.
return {
    "goolord/alpha-nvim",
    dependencies = {
        "nvim-tree/nvim-web-devicons"
    },
    config = function()
        local telescope = require("telescope")
        local dashboard = require("alpha.themes.dashboard")
        dashboard.section.buttons.val = vim.tbl_deep_extend(
            "force",
            dashboard.section.buttons.val,
            {
                dashboard.button("q", "󰅚  Quit NVIM", ":qa<CR>"),
                dashboard.button("SPC p", "Open Recent Projects", ":Telescope projects<CR>")
            }
        )
        require("alpha").setup(dashboard.config)
        -- require("alpha").setup(require("alpha.themes.startify").config)
    end
}
