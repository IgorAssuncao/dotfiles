local Keymaps = require("base.keymaps").Keymaps

function Toggleterm_set_terminal_keymaps()
  local buffer = 0
  local keymaps = {
    { mode = "t", keys = [[<C-\><C-\>]], cmd = [[<C-\><C-n>]],
      opts = { buffer = buffer, desc = "Exit insert mode inside terminal" } },
    { mode = "t", keys = "<C-h>", cmd = [[<Cmd>wicmd h<CR>]],
      opts = { buffer = buffer, desc = "Move to left terminal" } },
    { mode = "t", keys = "<C-j>", cmd = [[<Cmd>wicmd j<CR>]],
      opts = { buffer = buffer, desc = "Move to bottom terminal" } },
    { mode = "t", keys = "<C-k>", cmd = [[<Cmd>wicmd k<CR>]],
      opts = { buffer = buffer, desc = "Move to up terminal" } },
    { mode = "t", keys = "<C-l>", cmd = [[<Cmd>wicmd l<CR>]],
      opts = { buffer = buffer, desc = "Move to right terminal" } }
  }
  Keymaps(keymaps)
end
