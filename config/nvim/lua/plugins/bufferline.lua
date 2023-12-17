return {
  "akinsho/bufferline.nvim",
  -- version = 'v4.*',
  dependencies = {
    "nvim-tree/nvim-web-devicons"
  },
  opts = {
    options = {
      active = true,
      always_show_bufferline = true,
      numbers = "ordinal",
      diagnostics_update_in_insert = true
    }
  }
  -- config = function()
  --     require("bufferline").setup()
  -- end
}
