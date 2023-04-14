local status_which_key, which_key = pcall(require, "which-key")
if not status_which_key then
  vim.notify("Error from plugins.p_telescope.keymaps: which-key not found.")
  return
end

local builtin = require("telescope.builtin")

which_key.register({
  ["<leader>"] = {
    f = {
      name = "Telescope Fuzzy [F]inder",
      b = { builtin.current_buffer_fuzzy_find, "Current [b]uffer fuzzy find" },
      f = { builtin.find_files, "Find [f]iles in cwd" },
      g = { name = "[G]it",
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
