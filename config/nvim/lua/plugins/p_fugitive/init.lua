require("plugins.p_fugitive.keymaps")

function open_fugitive_in_floating_window()
  local width = 100
  local height = 25

  local buffer = vim.api.nvim_create_buf(false, true)

  local ui = vim.api.nvim_list_uis()[1]

  local opts = {
    relative = "editor",
    width = width,
    height = height,
    col = (ui.width / 2) - (width / 2),
    row = (ui.height / 2) - (height / 2),
    anchor = "NW",
    style = "minimal"
  }

  local win = vim.api.nvim_open_win(buffer, 1, opts)
end

local keymaps = {
  { keys = "<leader>za", cmd = function()
    open_fugitive_in_floating_window()
  end }
}

BASE.set_keymaps(keymaps)
