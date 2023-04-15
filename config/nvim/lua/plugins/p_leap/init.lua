local status_leap, leap = pcall(require, "leap")
if not status_leap then
  vim.notify("Error from plugins.p_leap: leap not found.")
  return
end

leap.add_default_mappings()
