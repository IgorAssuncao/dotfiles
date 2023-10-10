local status_bufferline, bufferline = pcall(require, "bufferline")
if not status_bufferline then
    vim.notify("Error from plugins.p_bufferline: bufferline not found.")
    return
end

bufferline.setup({
    options = {
        active = true,
        always_show_bufferline = true,
        numbers = "ordinal",
        diagnostics_update_in_insert = true
    }
})
