local M = {}

local status, which_key = pcall(require, "which-key")
if not status then
    vim.notify("Error from plugins.lsp.keymaps: which-key not found.")
end

function RegisterKeysIntoVimHelp()
    which_key.add({
        { "<leader>l",  group = "[D]efinition" },
        { "<leader>lp", function() BASE.peekDefinition() end,        desc = "[P]eek" },
        { "<leader>lg", function() vim.lsp.buf.definition() end,     desc = "[G]o desc = to in current window" },
        { "<leader>ls", function() BASE.split_definition() end,      desc = "Open in adesc =  [S]plit window" },
        { "<leader>lv", function() BASE.split_definition("v") end,   desc = "Open in a desc = [V]ertical split window" },
        { "<leader>li", function() vim.lsp.buf.implementation() end, desc = "[I]mplementation" },
        { "<leader>lr", function() vim.lsp.buf.references() end,     desc = "[R]eferences" },
        { "<leader>lR", function() vim.lsp.buf.rename() end,         desc = "[R]ename" },
    })
end

vim.cmd([[
autocmd FileType help lua RegisterKeysIntoVimHelp()
]])

return M
