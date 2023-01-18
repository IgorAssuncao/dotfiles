PLUGINS.telescope.setup {
  defaults = {
    file_ignore_patterns = {
      "packer.nvim",
      "undodir",
      "node_modules",
      "venv",
      "plugin/packer_compiled.lua",
    }
  }
}

require("plugins.p_telescope.keymaps")
