-- NOTE: For some reason this isn't working.
return {
    'numToStr/Comment.nvim',
    event = "VeryLazy",
    -- opts = {},
    config = function()
        require("Comment").setup()
    end
}
