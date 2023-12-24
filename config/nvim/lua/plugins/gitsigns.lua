-- Plugin for having Git related signs in Nvim.

return {
    "lewis6991/gitsigns.nvim",
    dependencies = {
        "nvim-lua/plenary.nvim"
    },
    event = "VeryLazy",
    config = function()
        require("gitsigns").setup()
    end
}
