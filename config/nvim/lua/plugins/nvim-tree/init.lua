require("nvim-tree").setup {
  filters = {
    dotfiles = true
  },
  renderer = {
    group_empty = false
  },
  view = {
    adaptive_size = true,
    side = "left"
  }
}

require("plugins.nvim-tree.keymaps")
