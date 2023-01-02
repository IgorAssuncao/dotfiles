require("telescope").setup{
  defaults = {
    file_ignore_patterns = {
      "packer.nvim",
      "undodir",
      "node_modules",
      "venv",
    }
  }
}

-- TODO: Separate telescope related keymaps
-- in its own file.
-- require("after.plugin.telescope.keymaps")

local builtin = require('telescope.builtin')

vim.keymap.set('n', '<leader>gf', builtin.git_files, {})
vim.keymap.set('n', '<leader>pf', builtin.find_files, {})
-- vim.keymap.set('n', '<leader>ps', function()
-- 	builtin.grep_string({ search = vim.fn.input("Grep > ") })
-- end)
