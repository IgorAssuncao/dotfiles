local keybind = require("base.keymaps").Keybind.set

function Toggleterm_set_terminal_keymaps()
  local buffer = 0
  keybind { mode = "t", keys = [[<C-\><C-\>]], cmd = [[<C-\><C-n>]],
    { buffer = buffer, desc = "Exit insert mode inside terminal" } }
  keybind { mode = "t", keys = "<C-h>", cmd = [[<Cmd>wicmd h<CR>]], { buffer = buffer, desc = "Move to left terminal" } }
  keybind { mode = "t", keys = "<C-j>", cmd = [[<Cmd>wicmd j<CR>]], { buffer = buffer, desc = "Move to bottom terminal" } }
  keybind { mode = "t", keys = "<C-k>", cmd = [[<Cmd>wicmd k<CR>]], { buffer = buffer, desc = "Move to up terminal" } }
  keybind { mode = "t", keys = "<C-l>", cmd = [[<Cmd>wicmd l<CR>]], { buffer = buffer, desc = "Move to right terminal" } }
end
