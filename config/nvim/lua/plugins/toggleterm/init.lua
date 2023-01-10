require("toggleterm").setup({
  direction = "float",
  open_mapping = [[<C-\>t]],
  insert_mappings = false,
  close_on_exit = true
})

require("plugins.toggleterm.keymaps")

vim.api.nvim_create_autocmd(
  {
    "TermOpen"
  },
  {
    pattern = "term://*toggleterm#*",
    command = "lua Toggleterm_set_terminal_keymaps()"
  }
)

local keybind = require("base.keymaps").Keybind.set

local terminal = require("toggleterm.terminal").Terminal

local git_terminal = terminal:new({ dir = "git_dir", direction = "float" })

local function _toggle_git_terminal()
  git_terminal:toggle()
end

keybind { keys = [[<C-\>g]], cmd = function() _toggle_git_terminal() end, { desc = "Toggle terminal opening git dir" } }

local htop_terminal = terminal:new({ cmd = "htop", hidden = true, close_on_exit = true })

local function _toggle_htop_terminal()
  htop_terminal:toggle()
end

keybind { keys = [[<C-\>h]], cmd = function() _toggle_htop_terminal() end, { desc = "Toggle terminal opening htop" } }

local lazygit_terminal = terminal:new({ cmd = "lazygit", hidden = true, close_on_exit = true })

local function _toggle_htop_terminal()
  htop_terminal:toggle()
end

keybind { keys = [[<C-\>g]], cmd = function() _toggle_htop_terminal() end, { desc = "Toggle terminal opening htop" } }
