local status_autopairs, autopairs = pcall(require, "nvim-autopairs")
if not status_autopairs then
  vim.notify("Error from plugins.p_autopairs: autopairs not found.")
  return
end

autopairs.setup()

local status_cmp, cmp = pcall(require, "cmp")
if not status_cmp then
  vim.notify("Error from plugins.p_autopairs: cmp not found.")
  return
end

local status_cmp_autopairs, cmp_autopairs = pcall(require, "nvim-autopairs.completion.cmp")
if not status_cmp_autopairs then
  vim.notify("Error from plugins.p_autopairs: nvim-autopairs.completion.cmp not found.")
  return
end

cmp.event:on(
  "confirm_done",
  cmp_autopairs.on_confirm_done()
)
