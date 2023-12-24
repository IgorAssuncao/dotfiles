-- Plugin that allows me to have versioning on undo,
-- just like git commits.

return {
    "mbbill/undotree",
    event = "VeryLazy",
    config = function()
        local which_key = require("which-key")

        which_key.register({
            ["<leader>"] = {
                u = { vim.cmd.UndotreeToggle, "[U]ndoTree Toggle" }
            }
        })
    end
}
