PLUGINS.lualine.setup({
  options = {
    theme = "auto" -- or horizon
  },
  sections = {
    lualine_a = { "mode" },
    lualine_b = { "branch" },
    lualine_c = { { "filename", path = 1 } },
    lualine_y = { "diagnostics" },
    lualine_z = { "location" }
  }
})

require("plugins.p_lualine.keymaps")
