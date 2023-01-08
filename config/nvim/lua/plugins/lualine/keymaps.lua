for i = 1, 9 do
  local key = "<leader>" .. i
  local cmd = i .. "<C-W>w"
  vim.keymap.set("n", key, cmd, { desc = "Move to window " .. i })
end
