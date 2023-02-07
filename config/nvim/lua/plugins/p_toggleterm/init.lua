local status_toggleterm, toggleterm = pcall(require, "toggleterm")
if not status_toggleterm then
  vim.notify("Error from plugins.p_toggleterm: toggleterm not found.")
  return
end

toggleterm.setup({
  direction = "float",
  open_mapping = [[<C-\>t]],
  insert_mappings = false,
  close_on_exit = true
})

require("plugins.p_toggleterm.keymaps")
