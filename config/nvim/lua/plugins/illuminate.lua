-- Plugin for navigating code based on current
-- code symbol (keywords).

return {
    "RRethy/vim-illuminate",
    event = "VeryLazy",
    config = function()
        local illuminate = require("illuminate")
        illuminate.configure()

        require("which-key").add({
            { "<leader>i", group = "[I]lluminate" },
            { "<leader>N", function() illuminate.goto_next_reference() end, desc = "[N]ext reference" },
            { "<leader>P", function() illuminate.goto_prev_reference() end, desc = "[P]revious reference" }
        })
    end
}
