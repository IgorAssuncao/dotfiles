PLUGINS.which_key.register({
  ["<leader>"] = {
    n = {
      name = "[N]vim-Tree",
      f = { function() vim.cmd { cmd = "NvimTreeFindFile" } end, "[F]ind File" },
      t = { function() vim.cmd { cmd = "NvimTreeToggle" } end, "[T]oggle" }
    }
  }
})
