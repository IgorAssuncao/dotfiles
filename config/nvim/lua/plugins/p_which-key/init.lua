local status_which_key, which_key = pcall(require, "which-key")
if not status_which_key then
  vim.notify("Error from plugins.p_which-key: which-key not found.")
  return
end

which_key.config = function()
  vim.o.timeout = true
  vim.o.timeoutlen = 300
  which_key.setup {}
end

require("plugins.p_which-key.keymaps")
