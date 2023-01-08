local keybind = require("base.keymaps").Keybind

for i = 1, 9 do
  local key = "<leader>" .. i
  local cmd = i .. "<C-W>w"
  keybind("n", key, cmd, { desc = "Move to window " .. i })
end
