local status_nightfox, nightfox = pcall(require, "nightfox")
if not status_nightfox then
    vim.notify("Error from plugins.p_nightfox.init: nightfox not found.")
    return
end

nightfox.setup {
    options = {
        dim_inactive = true,
        transparent = true
    }
}
