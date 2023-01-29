local status_functions, functions = pcall(require, "base.functions")
if not status_functions then
  vim.notify("Error requiring base.functions")
  return
end

local defs = require("base.defaults"):init()

-- Custom global base table
BASE = {
  defaults = defs.defaults,
  get_all_lsp_servers_names = defs.get_all_lsp_servers_names,
  protected_require = functions.protected_require
}

-- Custom global plugins table
PLUGINS = {
  packer = BASE.protected_require("plugins.packer"),
  which_key = BASE.protected_require("which-key")
}

BASE.protected_require("base.keymaps")
BASE.protected_require("base.settings")
BASE.protected_require("base.text")

-- local home = os.getenv("HOME") .. "/"
-- local asdf_shims_path = home .. ".asdf/shims"
--
-- vim.api.nvim_command("set runtimepath^=" .. asdf_shims_path)
-- vim.api.nvim_command('let &packpath = &runtimepath')
-- vim.api.nvim_command('source ~/.vim/vimrc')
