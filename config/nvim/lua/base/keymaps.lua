vim.g.mapleader = " "

local function set_keybind(params)
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

local function set_multiple_keybinds(keybinds)
  for k, v in pairs(keybinds) do
    set_keybind(v)
  end
end

-- Explorer
set_keybind { keys = "<leader>e", cmd = vim.cmd.Ex, opts = { desc = "[E]xplorer" } }

set_keybind { keys = "<leader>q", cmd = vim.cmd.quit, opts = { desc = "[Q]uit" } }
set_keybind { keys = "<leader>w", cmd = vim.cmd.write, opts = { desc = "[W]rite" } }
set_keybind { keys = "<leader>x", cmd = vim.cmd.exit, opts = { desc = "E[X]it" } }

-- Clear Search Highlighting
set_keybind { keys = "<leader>c", cmd = vim.cmd('nohls'), opts = { desc = "[C]lear Search Highlighting" } }

-- Navigation
-- -- Panels
set_keybind { keys = "<C-H>", cmd = "<C-W><C-H>", opts = { desc = "Move to left window" } }
set_keybind { keys = "<C-J>", cmd = "<C-W><C-J>", opts = { desc = "Move to down window" } }
set_keybind { keys = "<C-K>", cmd = "<C-W><C-K>", opts = { desc = "Move to up window" } }
set_keybind { keys = "<C-L>", cmd = "<C-W><C-L>", opts = { desc = "Move to right window" } }
-- TODO: discover how to make it work:
-- Keybind("n", "<C-H>", vim.cmd.wincmd('h'))
-- Keybind("n", "<C-J>", vim.cmd.wincmd('j'))
-- Keybind("n", "<C-K>", vim.cmd.wincmd('k'))
-- Keybind("n", "<C-L>", vim.cmd.wincmd('l'))

-- -- Buffers
set_keybind { keys = "<leader>bn", cmd = vim.cmd.bn, opts = { desc = "[B]uffer [n]ext" } }
set_keybind { keys = "<leader>bp", cmd = vim.cmd.bp, opts = { desc = "[B]uffer [p]revious" } }
set_keybind { keys = "<leader>bd", cmd = vim.cmd.bd, opts = { desc = "[B]uffer [d]elete" } }

set_keybind { mode = "v", keys = "J", cmd = ":m '>+1<CR>gv=gv", opts = { desc = "Move current selection downwards." } }
set_keybind { mode = "v", keys = "K", cmd = ":m '<-2<CR>gv=gv", opts = { desc = "Move current selection upwards." } }

set_keybind { keys = "<C-d>", cmd = "<C-d>zz", opts = { desc = "Scroll down with cursor in the middle of buffer" } }
set_keybind { keys = "<C-u>", cmd = "<C-u>zz", opts = { desc = "Scroll up with cursor in the middle of buffer" } }

set_keybind { mode = "x", keys = "<leader>p", cmd = "\"_dP", opts = { desc = "Keep old paste in paste buffer" } }

-- Yank into system clipboard
set_keybind { mode = "v", keys = "<leader>y", cmd = "\"+y",
  opts = { desc = "Yank into system clipboard while in visual mode" } }

return { Keybind = { set = set_keybind, mult = set_multiple_keybinds } }
