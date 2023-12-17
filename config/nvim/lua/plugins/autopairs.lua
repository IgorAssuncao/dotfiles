return {
    "windwp/nvim-autopairs",
    dependencies = {
        "hrsh7th/nvim-cmp"
    },
    opts = {
        check_ts = true
    },
    init = function()
        require("cmp").event:on(
            "confirm_done",
            require("nvim-autopairs.completion.cmp").on_confirm_done()
        )
    end
}
