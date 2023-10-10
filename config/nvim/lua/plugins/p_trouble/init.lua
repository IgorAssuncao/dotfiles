local status_trouble, trouble = pcall(require, "trouble")
if not status_trouble then
    vim.notify("Error from plugins.p_trouble: trouble not found.")
    return
end

trouble.setup()

local status_which_key, which_key = pcall(require, "which-key")
if not status_which_key then
    vim.notify("Error from plugins.p_trouble: which-key not found.")
    return
end

which_key.register({
    ["<leader>"] = {
        T = {
            name = "[T]rouble",
            {
                T = { function() trouble.open() end, "[T]oggle Trouble" },
                w = { function() trouble.open("workspace_diagnostics") end, "[W]orkspace diagnostics" },
                d = { function() trouble.open("document_diagnostics") end, "[D]ocument diagnostics" },
                q = { function() trouble.open("quickfix") end, "[Q]uickFix" },
                l = { function() trouble.open("loclist") end, "[L]ocList" },
                r = { function() trouble.open("lsp_references") end, "Lsp [R]eferences" }
            }
        }
    }
})
