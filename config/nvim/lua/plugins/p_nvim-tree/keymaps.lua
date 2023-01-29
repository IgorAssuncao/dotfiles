local status_which_key, which_key = pcall(require, "which-key")
if not status_which_key then
  vim.notify("Error from plugins.p_nvim-tree.keymaps: which-key not found.")
  return
end

which_key.register({
  ["<leader>"] = {
    n = {
      name = "[N]vim-Tree",
      f = { function() vim.cmd { cmd = "NvimTreeFindFile" } end, "[F]ind File" },
      t = { function() vim.cmd { cmd = "NvimTreeToggle" } end, "[T]oggle" }
    }
  }
})
