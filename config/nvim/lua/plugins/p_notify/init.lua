local status_notify, notify = pcall(require, "notify")
if not status_notify then
    vim.notify("Error from plugins.p_notify: notify not found.")
    return
end

notify.setup({
    background_colour = "#000000",
    fps = 60,
    render = "default",
    stages = "fade_in_slide_out",
    timeout = 2500
})
