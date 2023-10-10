local status_gitsigns, gitsigns = pcall(require, "gitsigns")
if not status_gitsigns then
    vim.notify("Error from plugins.p_gitsigns: gitsigns not found.")
    return
end

gitsigns.setup()
