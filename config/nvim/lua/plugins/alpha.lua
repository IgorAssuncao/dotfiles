-- Plugin that allows a nicer startup menu.
return {
    "goolord/alpha-nvim",
    dependencies = {
        "nvim-tree/nvim-web-devicons"
    },
    config = function()
        require("alpha").setup(require("alpha.themes.dashboard").config)
        -- require("alpha").setup(require("alpha.themes.startify").config)
    end
}
