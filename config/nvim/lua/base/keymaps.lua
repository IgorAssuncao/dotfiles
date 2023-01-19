vim.g.mapleader = " "

vim.cmd.mapclear()

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

function BASE.set_keymaps(keymaps_list)
  for _, v in pairs(keymaps_list) do
    set_keymap(v)
  end
end

local keymaps = {
  -- Navigation
  -- -- Panels
  -- -- -- These are the only ones that aren't overriding when using which_key.
  -- -- -- So I decided to leave them here for now.
  { keys = "<C-H>", cmd = "<C-W><C-H>", opts = { desc = "Move to left window" } },
  { keys = "<C-J>", cmd = "<C-W><C-J>", opts = { desc = "Move to down window" } },
  { keys = "<C-K>", cmd = "<C-W><C-K>", opts = { desc = "Move to up window" } },
  { keys = "<C-L>", cmd = "<C-W><C-L>", opts = { desc = "Move to right window" } },
}

-- for i = 1, 9 do
--   local key = "<leader>b" .. i
--   local cmd = "buffer " .. i
--   table.insert(keymaps, { keys = key, cmd = cmd, opts = { desc = "Move to buffer " .. i } })
-- end
--
-- print(vim.cmd.buffers())

BASE.set_keymaps(keymaps)

PLUGINS.which_key.register({
  -- ["<C-H>"] = { function() vim.cmd.wincmd('h') end, "Move to window on the left" },
  -- ["<C-J>"] = { function() vim.cmd.wincmd('j') end, "Move to window below" },
  -- ["<C-K>"] = { function() vim.cmd.wincmd('k') end, "Move to window above" },
  -- ["<C-L>"] = { function() vim.cmd.wincmd('l') end, "Move to window on the right" },
  ["<leader>"] = {
    name = "Custom",
    C = {
      function() vim.cmd("nohls") end, "[C]lear Search Highlighting"
    },
    E = {
      vim.cmd.Ex, "[E]xplorer"
    },
    b = {
      name = "[B]uffer",
      d = { vim.cmd.bd, "[D]elete", },
      n = { vim.cmd.bn, "[N]ext" },
      p = { vim.cmd.bp, "[P]revious" },
    },
    q = { vim.cmd.quit, "[Q]uit" },
    w = { vim.cmd.write, "[W]rite" },
    x = { vim.cmd.exit, "E[x]it" }
  }
})

for i = 1, 9, 1 do
  local key = "<leader>" .. i
  local cmd = i .. "<C-W>w"
  PLUGINS.which_key.register({
    [key] = { cmd, "move to window " .. i }
  })
end

PLUGINS.which_key.register({
  [""] = {
    name = "Visual Character Mode",
    J = { ":m '>+1<CR>gv=gv", "Move current selection downwards" },
    K = { ":m '<-2<CR>gv=gv", "Move current selection upwards" }
  },
  ["<leader>y"] = { "\"+y", "Yank into system clipboard while in visual mode" }
}, { mode = "v" })

PLUGINS.which_key.register({
  ["<leader>"] = {
    name = "[X] mode",
    P = { "\"_dP", "Keep old past in paste buffer" }
  }
}, { mode = "x" })
