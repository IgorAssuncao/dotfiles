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
      f = { builtin.find_files, "Find [f]iles in cwd" },
      g = { builtin.git_files, "[G]it Files" },
      l = { builtin.live_grep, "[L]ive [G]rep" },
      w = { function() builtin.grep_string({ search = vim.fn.input("Grep > ") }) end, "Find [W]ord" }
    }
  }
})
