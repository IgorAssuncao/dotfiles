vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

return {
  "nvim-tree/nvim-tree.lua",
  dependencies = {
    "nvim-tree/nvim-web-devicons"
  },
  opts = {
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
      number = true,
      relativenumber = true,
      side = "left",
      float = {
        enable = false
      }
    }
  },
  init = function()
    require("which-key").register({
      ["<leader>"] = {
        n = {
          name = "[N]vim-Tree",
          f = { function() vim.cmd { cmd = "NvimTreeFindFile" } end, "[F]ind File" },
          t = { function() vim.cmd { cmd = "NvimTreeToggle" } end, "[T]oggle" }
        }
      }
    })
  end,
  -- config = function()
  --   require("nvim-tree").setup(opts)
  -- end
}
