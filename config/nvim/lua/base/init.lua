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

BASE.protected_require("base.settings")
BASE.protected_require("base.text")

local status, _ = pcall(require, "plugins.packer")
if not status then
  vim.notify("Error in requiring plugins.packer")
  return
end
-- keymaps is being required after packer
-- because of which-key plugin that registers
-- keymaps.
require("base.keymaps")

-- local home = os.getenv("HOME") .. "/"
-- local asdf_shims_path = home .. ".asdf/shims"
--
-- vim.api.nvim_command("set runtimepath^=" .. asdf_shims_path)
-- vim.api.nvim_command('let &packpath = &runtimepath')
-- vim.api.nvim_command('source ~/.vim/vimrc')
