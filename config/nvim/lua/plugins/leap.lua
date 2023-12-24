-- Plugin for better code navigation.
-- I can navigate forwards and backwards to a
-- single or a set of characters.

return {
    "ggandor/leap.nvim",
    event = "VeryLazy",
    config = function()
        require("leap").add_default_mappings()
    end
}
