PLUGINS.nvim_tree.setup {
  diagnostics = {
    enable = true,
    show_on_dirs = true
  },
  filters = {
    dotfiles = true
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
    enable = true,
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
