PLUGINS.toggleterm.setup({
  direction = "float",
  open_mapping = [[<C-\>t]],
  insert_mappings = false,
  close_on_exit = true
})

require("plugins.p_toggleterm.keymaps")

local terminal = require("toggleterm.terminal").Terminal

local git_terminal = terminal:new({ dir = "git_dir", direction = "float" })

local htop_terminal = terminal:new({ cmd = "htop", hidden = true, close_on_exit = true })

local lazygit_terminal = terminal:new({ cmd = "lazygit", hidden = true, close_on_exit = true })

local _terminal_below = terminal:new({ direction = "horizontal", close_on_exit = true })

PLUGINS.which_key.register({
  ["<C-\\>"] = {
    name = "Toggleterm",
    d = { function() _terminal_below:toggle() end, "Toggle terminal below" },
    G = { function() lazygit_terminal:toggle() end, "Toggle Lazygit terminal" },
    g = { function() git_terminal:toggle() end, "Toggle git dir terminal" },
    h = { function() htop_terminal:toggle() end, "Toggle htop terminal" },
  }
})
