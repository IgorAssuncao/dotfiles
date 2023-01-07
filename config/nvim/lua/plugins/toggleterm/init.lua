require("toggleterm").setup({
  direction = "float",
  open_mapping = "<leader>tn",
  insert_mappings = false,
  close_on_exit = false
})

function Toggleterm_set_terminal_keymaps()
  local opts = { buffer = 0 }
  vim.keymap.set('t', '<esc>', [[<C-\><C-n>]], opts)
  vim.keymap.set('t', '<C-h>', [[<Cmd>wicmd h<CR>]], opts)
  vim.keymap.set('t', '<C-j>', [[<Cmd>wicmd j<CR>]], opts)
  vim.keymap.set('t', '<C-k>', [[<Cmd>wicmd k<CR>]], opts)
  vim.keymap.set('t', '<C-l>', [[<Cmd>wicmd l<CR>]], opts)
end

vim.api.nvim_create_autocmd(
  {
    "TermOpen"
  },
  {
    pattern = "term://*toggleterm#*",
    command = "lua Toggleterm_set_terminal_keymaps()"
  }
)

local terminal = require("toggleterm.terminal").Terminal

local cwd_terminal = terminal:new({ dir = "git_dir", direction = "float" })

local function _toggle_cwd_terminal()
  cwd_terminal:toggle()
end

vim.keymap.set("n", "<leader>tt", function() _toggle_cwd_terminal() end)

local htop_terminal = terminal:new({ cmd = "htop", hidden = true })

local function _toggle_htop_terminal()
  htop_terminal:toggle()
end

vim.keymap.set("n", "<leader>th", function() _toggle_htop_terminal() end)
