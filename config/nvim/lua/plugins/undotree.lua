return {
  "mbbill/undotree",
  config = function()
    local which_key = require("which-key")

    which_key.register({
      ["<leader>"] = {
        u = { vim.cmd.UndotreeToggle, "[U]ndoTree Toggle" }
      }
    })
  end
}
