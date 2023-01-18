PLUGINS.toggleterm.setup({
  direction = "float",
  open_mapping = [[<C-\>t]],
  insert_mappings = false,
  close_on_exit = true
})

require("plugins.p_toggleterm.keymaps")

local keymaps = {}

local terminal = require("toggleterm.terminal").Terminal

local git_terminal = terminal:new({ dir = "git_dir", direction = "float" })

local function _toggle_git_terminal()
  git_terminal:toggle()
end

table.insert(keymaps, { keys = [[<C-\>g]], cmd = function() _toggle_git_terminal() end,
  opts = { desc = "Toggle terminal opening git dir" } })

local htop_terminal = terminal:new({ cmd = "htop", hidden = true, close_on_exit = true })

local function _toggle_htop_terminal()
  htop_terminal:toggle()
end

table.insert(keymaps, { keys = [[<C-\>h]], cmd = function() _toggle_htop_terminal() end,
  opts = { desc = "Toggle terminal opening htop" } })

local lazygit_terminal = terminal:new({ cmd = "lazygit", hidden = true, close_on_exit = true })

local function _toggle_lazygit_terminal()
  lazygit_terminal:toggle()
end

table.insert(keymaps, { keys = [[<C-\>G]], cmd = function() _toggle_lazygit_terminal() end,
  opts = { desc = "Toggle terminal opening lazygit" } })


local _terminal_below = terminal:new({ direction = "horizontal", close_on_exit = true })

local function _toggle_terminal_below()
  _terminal_below:toggle()
end

table.insert(keymaps, { keys = [[<C-\>d]], cmd = function() _toggle_terminal_below() end,
  opts = { desc = "Toggle terminal below" } })

BASE.set_keymaps(keymaps)
