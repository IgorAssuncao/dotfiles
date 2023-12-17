return {
  "nvim-telescope/telescope.nvim",
  branch = "0.1.x",
  dependencies = {
    "nvim-lua/plenary.nvim",
    -- Telescope extensions
    "ahmedkhalf/project.nvim"
  },
  config = function()
    local telescope = require("telescope")

    local status_trouble, trouble = pcall(require, "trouble.providers.telescope")
    local mappings = {}
    if not status_trouble then
      vim.notify("Error from plugins.telescope: trouble not found.\nUnable to bind trouble keymaps to telescope")
    else
      mappings = {
        i = { ["<c-t>"] = trouble.open_with_trouble },
        n = { ["<c-t>"] = trouble.open_with_trouble }
      }
    end

    local which_key = require("which-key")

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
        mappings = mappings,
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

    local builtin = require("telescope.builtin")

    which_key.register({
      ["<leader>"] = {
        f = {
          name = "Telescope Fuzzy [F]inder",
          b = { builtin.current_buffer_fuzzy_find, "Current [b]uffer fuzzy find" },
          f = { builtin.find_files, "Find [f]iles in cwd" },
          g = {
            name = "[G]it",
            b = { builtin.git_bcommits, "[B]commits" },
            c = { builtin.git_commits, "[C]ommits" },
            f = { builtin.git_files, "[F]iles" },
            s = { builtin.git_status, "Files in git [S]tatus" }
          },
          h = { builtin.help_tags, "[H]elp Tags" },
          l = { builtin.live_grep, "[L]ive [G]rep" },
          r = { builtin.resume, "[R]esume" },
          w = { function() builtin.grep_string({ search = vim.fn.input("Grep > ") }) end, "Find [W]ord" }
        }
      }
    })

    -- Extensions
    local project = require("project_nvim")
    project.setup()

    which_key.register({
      ["<leader>"] = {
        f = {
          name = "Telescope Fuzzy [F]inder",
          p = { function()
            telescope.extensions.projects.projects {}
          end, "[P]rojects" }
        }
      }
    })

    telescope.load_extension("projects")
    telescope.load_extension("notify")
  end
}