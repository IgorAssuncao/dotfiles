local status_notify, notify = pcall(require, "notify")
if not status_notify then
  vim.notify("Error from plugins.p_notify: notify not found.")
  return
end

notify.setup({
  background = "#000000",
  background_color = "#000000",
  render = "default",
  stages = "fade_in_slide_out"
})
