require("telescope").setup{
  defaults = {
    file_ignore_patterns = {
      "packer.nvim",
      "undodir",
      "node_modules",
      "venv",
    }
  }
}

require("after.plugin.telescope.keymaps")
