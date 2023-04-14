local status_telescope, telescope = pcall(require, "telescope")
if not status_telescope then
  vim.notify("Error from plugins.p_telescope: telescope not found.")
  return
end

telescope.setup {
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

-- Extensions
require("plugins.p_telescope.p_project")
