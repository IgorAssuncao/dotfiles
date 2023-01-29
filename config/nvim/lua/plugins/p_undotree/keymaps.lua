local status_which_key, which_key = pcall(require, "which-key")
if not status_which_key then
  vim.notify("Error from plugins.p_undotree.keymaps: which-key not found.")
  return
end

which_key.register({
  ["<leader>"] = {
    u = { vim.cmd.UndotreeToggle, "[U]ndoTree Toggle" }
  }
})
