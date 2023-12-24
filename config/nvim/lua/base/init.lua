-- vim.inspect(table) allows table inspection, it returns the elements from the table passed as parameter

-- local status_notify, notify = pcall(require, "notify")
-- if not status_notify then
--     vim.notify("Error from base: notify not found.")
--     return
-- else
--     vim.notify = notify
-- end

local status_functions, functions = pcall(require, "base.functions")
if not status_functions then
    vim.notify("Error requiring base.functions", "error")
    return
end

local defs = require("base.defaults"):init()
local functions = require("base.functions"):init()

-- Custom global base table
BASE = {
    defaults = defs.defaults,
    get_all_lsp_servers_names = defs.get_all_lsp_servers_names,
    functions = functions
}

BASE.functions.protected_require("base.settings")
BASE.functions.protected_require("base.text")
BASE.functions.setup_highlight_groups()

-- local home = os.getenv("HOME") .. "/"
-- local asdf_shims_path = home .. ".asdf/shims"
--
-- vim.api.nvim_command("set runtimepath^=" .. asdf_shims_path)
-- vim.api.nvim_command('let &packpath = &runtimepath')
-- vim.api.nvim_command('source ~/.vim/vimrc')
