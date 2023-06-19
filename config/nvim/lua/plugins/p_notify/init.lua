local status_notify, notify = pcall(require, "notify")
if not status_notify then
  vim.notify("Error from plugins.p_notify: notify not found.")
  return
end

notify.setup({
  background_color = "#000000"
})
