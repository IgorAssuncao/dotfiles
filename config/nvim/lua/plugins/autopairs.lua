-- Plugin that allows autopairing on symbols.

return {
    "windwp/nvim-autopairs",
    dependencies = {
        "hrsh7th/nvim-cmp"
    },
    event = "InsertEnter",
    config = function()
        require("nvim-autopairs").setup({
            check_ts = true
        })
        require("cmp").event:on(
            "confirm_done",
            require("nvim-autopairs.completion.cmp").on_confirm_done()
        )
    end
}
