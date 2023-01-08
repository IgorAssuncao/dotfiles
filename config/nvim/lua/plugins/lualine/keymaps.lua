local keybind = require("base.keymaps").Keybind.set

for i = 1, 9 do
  local key = "<leader>" .. i
  local cmd = i .. "<C-W>w"
  keybind { keys = key, cmd = cmd, { desc = "Move to window " .. i } }
end
