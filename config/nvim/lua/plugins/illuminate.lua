-- Plugin for navigating code based on current
-- code symbol (keywords).

return {
    "RRethy/vim-illuminate",
    event = "VeryLazy",
    config = function()
        local illuminate = require("illuminate")
        illuminate.configure()

        require("which-key").register({
            ["<leader>"] = {
                i = {
                    name = "[I]lluminate",
                    n = { function() illuminate.goto_next_reference() end, "[N]ext reference" },
                    p = { function() illuminate.goto_prev_reference() end, "[P]revious reference" }
                }
            }
        })
    end
}
