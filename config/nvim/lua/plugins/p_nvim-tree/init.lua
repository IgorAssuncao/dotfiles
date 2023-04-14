local status_nvim_tree, nvim_tree = pcall(require, "nvim-tree")
if not status_nvim_tree then
  vim.notify("Error from plugins.p_nvim-tree: nvim-tree not found.")
  return
end

vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

vim.api.nvim_create_autocmd(
  {
    "VimEnter"
  },
  {
    callback = function(data)
      local directory = vim.fn.isdirectory(data.file) == 1
      if not directory then
        return
      end

      require("nvim-tree.api").tree.open()
    end
  }
)

nvim_tree.setup {
  diagnostics = {
    enable = true,
    show_on_dirs = true
  },
  filters = {
    dotfiles = false
  },
  git = {
    enable = true,
    ignore = false
  },
  renderer = {
    group_empty = false,
    highlight_git = true,
    full_name = true,
    icons = {
      webdev_colors = true,
      git_placement = "before",
      modified_placement = "before",
      show = {
        file = true,
        folder = true,
        folder_arrow = true,
        git = true
      }
    },
    indent_markers = {
      enable = true,
      icons = {
        bottom = "-",
        corner = "└ ",
        edge = "| ",
        item = "| ",
        none = " "
      }
    },
  },
  update_focused_file = {
    enable = false,
    update_cwd = false,
    ignore_list = {}
  },
  view = {
    adaptive_size = true,
    hide_root_folder = false,
    number = true,
    relativenumber = true,
    side = "left",
    float = {
      enable = false
    }
  }
}

require("plugins.p_nvim-tree.keymaps")
