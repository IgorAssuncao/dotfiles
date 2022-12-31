vim.g.mapleader = " "

-- Explorer
vim.keymap.set("n", "<leader>e", vim.cmd.Ex)

vim.keymap.set("n", "<leader>q", vim.cmd.quit)
vim.keymap.set("n", "<leader>w", vim.cmd.write)
vim.keymap.set("n", "<leader>x", vim.cmd.exit)

-- Clear Search Highlighting
vim.keymap.set("n", "<leader>c", vim.cmd('nohls'))

-- Navigation
-- -- Panels
vim.keymap.set("n", "<C-H>", "<C-W><C-H>")
vim.keymap.set("n", "<C-J>", "<C-W><C-J>")
vim.keymap.set("n", "<C-K>", "<C-W><C-K>")
vim.keymap.set("n", "<C-L>", "<C-W><C-L>")
-- TODO: discover how to make it work:
-- vim.keymap.set("n", "<C-H>", vim.cmd.wincmd('h'))
-- vim.keymap.set("n", "<C-J>", vim.cmd.wincmd('j'))
-- vim.keymap.set("n", "<C-K>", vim.cmd.wincmd('k'))
-- vim.keymap.set("n", "<C-L>", vim.cmd.wincmd('l'))

-- -- Buffers
vim.keymap.set("n", "<leader>bn", vim.cmd.bn)
vim.keymap.set("n", "<leader>bp", vim.cmd.bp)
vim.keymap.set("n", "<leader>bd", vim.cmd.bd)

-- Moving text around
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

-- Scroll but with cursos in the middle
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")

-- Keep old paste in paste buffer
vim.keymap.set("x", "<leader>p", "\"_dP")

-- Yank into system clipboard
vim.keymap.set("n", "<leader>y", "\"+y")
vim.keymap.set("v", "<leader>y", "\"+y")
