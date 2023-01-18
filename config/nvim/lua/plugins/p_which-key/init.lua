PLUGINS.which_key.config = function()
  vim.o.timeout = true
  vim.o.timeoutlen = 300
  PLUGINS.which_key.setup {}
end

require("plugins.p_which-key.keymaps")
