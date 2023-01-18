local Keymaps = require("base.keymaps").Keymaps

local keymaps = {}

for i = 1, 9 do
  local key = "<leader>" .. i
  local cmd = i .. "<C-W>w"
  table.insert(keymaps, { keys = key, cmd = cmd, opts = { desc = "Move to window " .. i } })
end

Keymaps(keymaps)
