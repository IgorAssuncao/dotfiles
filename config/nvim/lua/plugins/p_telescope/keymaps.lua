local builtin = require("telescope.builtin")

PLUGINS.which_key.register({
  ["<leader>"] = {
    f = {
      name = "Telescope Fuzzy [F]inder",
      f = { builtin.find_files, "Find [f]iles in cwd" },
      g = { builtin.git_files, "[G]it Files" },
      l = { builtin.live_grep, "[L]ive [G]rep" },
      w = { function() builtin.grep_string({ search = vim.fn.input("Grep > ") }) end, "Find [W]ord" }
    }
  }
})
