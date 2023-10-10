local status_which_key, which_key = pcall(require, "which-key")
if not status_which_key then
    vim.notify("Error from plugins.p_undotree.keymaps: which-key not found.")
    return
end

which_key.register({
    ["<leader>W"] = {
        W = { function() vim.cmd { cmd = "WhichKey" } end, "[W]hich [K]ey Toggle" },
        N = { "<cmd>WhichKey '' n<cr>", "[W]hich [K]ey [N]ormal mode Toggle" },
        I = { "<cmd>WhichKey '' i<cr>", "[W]hich [K]ey [I]nsert mode Toggle" },
        V = { "<cmd>WhichKey '' v<cr>", "[W]hich [K]ey [V]isual mode Toggle" },
        C = { "<cmd>WhichKey '' c<cr>", "[W]hich [K]ey [C]ommand mode Toggle" },
    },
    ["<leader>L"] = {
        name = "[L]anguages tools"
    },
})
