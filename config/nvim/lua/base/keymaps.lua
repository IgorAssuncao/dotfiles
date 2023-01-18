vim.g.mapleader = " "

local function set_keymap(params)
  local mode = params.mode or "n"

  if params.keys then
    keys = params.keys
  end

  if params.cmd then
    cmd = params.cmd
  end

  local _opts = {
    remap = false
  }

  if params.opts then
    for k, v in pairs(params.opts) do
      _opts[k] = v
    end
  end

  -- if keys == "<leader>gPR" or keys == "<leader>gPP" then
  --   print(mode, keys, cmd)
  --   for k, v in pairs(_opts) do
  --     print(k, v)
  --   end
  -- end

  return vim.keymap.set(mode, keys, cmd, _opts)
end

local function set_keymaps(keymaps_list)
  for _, v in pairs(keymaps_list) do
    set_keymap(v)
  end
end

local keymaps = {
  -- Explorer
  { keys = "<leader>e", cmd = vim.cmd.Ex, opts = { desc = "[E]xplorer" } },

  { keys = "<leader>q", cmd = vim.cmd.quit, opts = { desc = "[Q]uit" } },
  { keys = "<leader>w", cmd = vim.cmd.write, opts = { desc = "[W]rite" } },
  { keys = "<leader>x", cmd = vim.cmd.exit, opts = { desc = "E[X]it" } },

  -- Clear Search Highlighting
  { keys = "<leader>c", cmd = vim.cmd('nohls'), opts = { desc = "[C]lear Search Highlighting" } },

  -- Navigation
  -- -- Panels
  { keys = "<C-H>", cmd = "<C-W><C-H>", opts = { desc = "Move to left window" } },
  { keys = "<C-J>", cmd = "<C-W><C-J>", opts = { desc = "Move to down window" } },
  { keys = "<C-K>", cmd = "<C-W><C-K>", opts = { desc = "Move to up window" } },
  { keys = "<C-L>", cmd = "<C-W><C-L>", opts = { desc = "Move to right window" } },
  -- TODO: discover how to make it work:
  -- set_keymap("n", "<C-H>", vim.cmd.wincmd('h'))
  -- set_keymap("n", "<C-J>", vim.cmd.wincmd('j'))
  -- set_keymap("n", "<C-K>", vim.cmd.wincmd('k'))
  -- set_keymap("n", "<C-L>", vim.cmd.wincmd('l'))

  -- -- Buffers
  { keys = "<leader>bn", cmd = vim.cmd.bn, opts = { desc = "[B]uffer [n]ext" } },
  { keys = "<leader>bp", cmd = vim.cmd.bp, opts = { desc = "[B]uffer [p]revious" } },
  { keys = "<leader>bd", cmd = vim.cmd.bd, opts = { desc = "[B]uffer [d]elete" } },

  { mode = "v", keys = "J", cmd = ":m '>+1<CR>gv=gv", opts = { desc = "Move current selection downwards." } },
  { mode = "v", keys = "K", cmd = ":m '<-2<CR>gv=gv", opts = { desc = "Move current selection upwards." } },

  { keys = "<C-d>", cmd = "<C-d>zz", opts = { desc = "Scroll down with cursor in the middle of buffer" } },
  { keys = "<C-u>", cmd = "<C-u>zz", opts = { desc = "Scroll up with cursor in the middle of buffer" } },

  { mode = "x", keys = "<leader>p", cmd = "\"_dP", opts = { desc = "Keep old paste in paste buffer" } },

  -- Yank into system clipboard
  { mode = "v", keys = "<leader>y", cmd = "\"+y",
    opts = { desc = "Yank into system clipboard while in visual mode" } }
}

set_keymaps(keymaps)

return { Keymaps = set_keymaps }
