local M = {}

local status, which_key = pcall(require, "which-key")
if not status then
    vim.notify("Error from plugins.lsp.keymaps: which-key not found.")
end

function RegisterKeysIntoVimHelp()
    which_key.register({
        ["<leader>"] = {
            l = {
                name = "[D]efinition",
                p = { function() BASE.peekDefinition() end, "[P]eek" },
                g = { function() vim.lsp.buf.definition() end, "[G]o to in current window" },
                s = { function() BASE.split_definition() end, "Open in a [S]plit window" },
                v = { function() BASE.split_definition("v") end, "Open in a [V]ertical split window" },
                i = { function() vim.lsp.buf.implementation() end, "[I]mplementation" },
                r = { function() vim.lsp.buf.references() end, "[R]eferences" },
                R = { function() vim.lsp.buf.rename() end, "[R]ename" },
            }
        }
    })
end

vim.cmd([[
autocmd FileType help lua RegisterKeysIntoVimHelp()
]])

return M
