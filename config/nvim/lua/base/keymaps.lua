vim.g.mapleader = " "

local keybind = vim.keymap.set

-- Explorer
keybind("n", "<leader>e", vim.cmd.Ex)

keybind("n", "<leader>q", vim.cmd.quit)
keybind("n", "<leader>w", vim.cmd.write)
keybind("n", "<leader>x", vim.cmd.exit)

-- Clear Search Highlighting
keybind("n", "<leader>c", vim.cmd('nohls'))

-- Navigation
-- -- Panels
keybind("n", "<C-H>", "<C-W><C-H>")
keybind("n", "<C-J>", "<C-W><C-J>")
keybind("n", "<C-K>", "<C-W><C-K>")
keybind("n", "<C-L>", "<C-W><C-L>")
-- TODO: discover how to make it work:
-- Keybind("n", "<C-H>", vim.cmd.wincmd('h'))
-- Keybind("n", "<C-J>", vim.cmd.wincmd('j'))
-- Keybind("n", "<C-K>", vim.cmd.wincmd('k'))
-- Keybind("n", "<C-L>", vim.cmd.wincmd('l'))

-- -- Buffers
keybind("n", "<leader>bn", vim.cmd.bn)
keybind("n", "<leader>bp", vim.cmd.bp)
keybind("n", "<leader>bd", vim.cmd.bd)

-- Moving text around while in visual mode
keybind("v", "J", ":m '>+1<CR>gv=gv")
keybind("v", "K", ":m '<-2<CR>gv=gv")

-- Scroll but with cursos in the middle
keybind("n", "<C-d>", "<C-d>zz")
keybind("n", "<C-u>", "<C-u>zz")

-- Keep old paste in paste buffer
keybind("x", "<leader>p", "\"_dP")

-- Yank into system clipboard
keybind("n", "<leader>y", "\"+y")
keybind("v", "<leader>y", "\"+y")

return { Keybind = keybind }
