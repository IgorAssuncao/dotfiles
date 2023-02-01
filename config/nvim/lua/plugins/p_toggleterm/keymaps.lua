local status_which_key, which_key = pcall(require, "which-key")
if not status_which_key then
  vim.notify("Error from plugins.p_nvim-tree.keymaps: which-key not found.")
  return
end

function Toggleterm_set_terminal_keymaps()
  local buffer = 0
  which_key.register({
    ["<C-\\>"] = {
      name = "Toggleterm",
      ["<C-\\>"] = { [[<C-\><C-n>]], "Exit insert mode inside terminal" },
      ["<C-h>"] = { [[<cmd>wincmd h<cr>]], "Move to left terminal" },
      ["<C-j>"] = { [[<cmd>wincmd j<cr>]], "Move to terminal below" },
      ["<C-k>"] = { [[<cmd>wincmd k<cr>]], "Move to terminal above" },
      ["<C-l>"] = { [[<cmd>wincmd l<cr>]], "Move to right terminal" },
    }
  }, { mode = "t", buffer = buffer })
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
