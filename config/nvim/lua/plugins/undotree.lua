-- Plugin that allows me to have versioning on undo,
-- just like git commits.

return {
    "mbbill/undotree",
    event = "VeryLazy",
    config = function()
        local which_key = require("which-key")

        which_key.add({
            { "<leader>u", vim.cmd.UndotreeToggle, desc = "[U]ndoTree Toggle" }
        })
    end
}
