-- Custom global base table
BASE = {}

-- Custom global plugins table
PLUGINS = {
  packer = require("plugins.packer")
}

local ok, which_key = pcall(require, "which-key")
if not ok then
  print("which-key not yet installed.")
  return
end
PLUGINS.which_key = which_key

local defs = require("base.defaults"):init()

BASE.defaults = defs.defaults
BASE.get_all_lsp_servers = defs.get_all_lsp_servers

require("base.keymaps")
require("base.settings")
require("base.text")

-- local home = os.getenv("HOME") .. "/"
-- local asdf_shims_path = home .. ".asdf/shims"
--
-- vim.api.nvim_command("set runtimepath^=" .. asdf_shims_path)
-- vim.api.nvim_command('let &packpath = &runtimepath')
-- vim.api.nvim_command('source ~/.vim/vimrc')
