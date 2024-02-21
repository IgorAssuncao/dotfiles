-- Plugin for commmenting in and out lines.

return {
    "numToStr/Comment.nvim",
    event = "VeryLazy",
    -- opts = {},
    config = function()
        require("Comment").setup()
    end
}
