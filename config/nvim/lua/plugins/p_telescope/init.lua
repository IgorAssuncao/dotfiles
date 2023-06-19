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
    },
    layout_config = {
      horizontal = {
        prompt_position = "top"
      }
    },
    pickers = {
      find_files = {
        hidden = true
      },
      live_grep = {
        only_sort_text = true
      },
      grep_string = {
        only_sort_text = true
      }
    },
    -- path_display = { "smart" },
    sorting_strategy = "ascending"
  }
}

require("plugins.p_telescope.keymaps")

-- Extensions
require("plugins.p_telescope.p_project")
telescope.load_extension("notify")
